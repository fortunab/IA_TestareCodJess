from tkinter import *
import networkx as nx
import matplotlib.pyplot as plt
import random
from PIL import ImageTk
from PIL import Image
import BreadthFirstSeach as BFS
import DepthFirstSearch as DFS

from Graph import Graph
from Node import Node


class GraphGenerator:
    def __init__(self, mainFrame, filePath, algName):
        self.mainFrame = mainFrame
        self.filePath = filePath
        self.algName = algName
        self.nodeList = []
        self.teamData = list()
        self.edgeDict = dict()
        self.imageList = list()
        self.counter = 1
        self.teamDataCounter = -1
        self.nextPressed = True
        self.mainFrame.title("Initial graph")
        self.mainFrame.geometry("1200x1050")
        self.mainFrame.config(bg="#828481")
        self.path = "Initial.png"
        self.graph_frame = Frame(self.mainFrame)
        Label(self.graph_frame,
              text="Initial graph").pack()
        self.readTeams()
        self.generateGraph()
        self.createButtons()
        self.chooseAlghorithm()

    def chooseAlghorithm(self):
        if self.algName.get() == 'BFS':
            self.imageList.extend(BFS.BreadthFirstSearch(self.myGraph, self.teamData).BFS())
        else:
            self.imageList.extend(DFS.DepthFirstSearch(self.myGraph, self.teamData).DFS(self.myGraph.root))

    def actionNextButton(self):
        if len(self.imageList) > self.counter:
            if not self.nextPressed:
                self.counter = self.counter + 1
            self.imageLabel.config(image=self.imageList[self.counter])
            self.imageLabel.image = self.imageList[self.counter]
            self.nextPressed = True
            self.counter = self.counter + 1
            self.teamDataCounter = self.teamDataCounter + 1
            self.backButton["state"] = "normal"
        if len(self.imageList) == self.counter:
            self.nextButton["state"] = "disabled"
        if len(self.teamData) != 0:
            if len(self.imageList) != self.counter:
                self.insertDataIntoTextArea()
            else:
                self.textArea.insert(END, "\nFINISH!!", 'color')

    def actionBackButton(self):
        if self.counter > 0:
            if self.nextPressed:
                self.counter = self.counter - 1
                self.nextPressed = False
            self.counter = self.counter - 1
            self.teamDataCounter = self.teamDataCounter - 1
            self.imageLabel.config(image=self.imageList[self.counter])
            self.imageLabel.image = self.imageList[self.counter]
            self.nextButton["state"] = "normal"
        if self.counter == 0:
            self.backButton["state"] = "disabled"
        if len(self.teamData) != 0:
            self.insertDataIntoTextArea()

    def insertDataIntoTextArea(self):
        self.textArea.delete("1.0", END)
        self.textArea.insert(END, "*** Group stages ***\n\n", 'color')
        self.appendGroupDates()
        # just for scrolling, don't mind it
        self.textArea.insert(END, "\n\n\n\n\n\n\n\n\n\n\n")
        self.textArea.yview_moveto(1)

    def appendGroupDates(self):
        groupStanding = ''
        for data in self.teamData[self.teamDataCounter]:
            groupStanding += data
        self.textArea.insert(END, groupStanding, 'color')

    def createButtons(self):
        self.nextButton = Button(self.graph_frame, text="Next Step", command=lambda: self.actionNextButton())
        self.nextButton.pack(side=RIGHT)
        self.backButton = Button(self.graph_frame, text="Back Step", command=lambda: self.actionBackButton())
        self.backButton.pack(side=LEFT)
        self.backButton["state"] = "disabled"
        self.backToMainInterface = Button(self.graph_frame, text="Back To Main Interface",
                                          command=lambda: self.goBack())
        self.backToMainInterface.pack(side=TOP)

    def goBack(self):
        self.mainFrame.destroy()

    def createPlaceForGroups(self):
        self.textArea = Text(self.mainFrame, height=4, width=25)
        scroll = Scrollbar(self.mainFrame)
        self.textArea.pack(side=LEFT, fill=Y)
        scroll.config(command=self.textArea.yview)
        self.textArea.config(yscrollcommand=scroll.set)
        scroll.pack(side=RIGHT, fill=Y)
        self.textArea.tag_configure('color',
                                    foreground='#476042',
                                    font=('Tempus Sans ITC', 12, 'bold'))

    def createBinaryTree(self):
        rootNode = self.nodeList[0]
        for i in range(0, len(self.nodeList) // 2):
            currentNode = self.nodeList[i]
            self.addDirectional(currentNode, self.nodeList[2 * i + 1])
            self.addDirectional(currentNode, self.nodeList[2 * i + 2])
            if currentNode not in self.edgeDict.keys():
                self.edgeDict[currentNode] = [self.nodeList[2 * i + 1], self.nodeList[2 * i + 2]]
            self.myGraph = Graph(self.nodeList, self.edgeDict, rootNode)

    def readTeams(self):
        fileContent = open(self.filePath, "r")
        teamNumber = 32
        for i in range(0, teamNumber):
            nodeData = fileContent.readline()
            nodeData = nodeData.strip('\n')
            teamName, abbreviation, country, pot = nodeData.split(' ')
            self.nodeList.append(Node(teamName, country, abbreviation, pot))
        random.shuffle(self.nodeList)
        self.nodeList.append(self.nodeList[-1])
        self.createBinaryTree()

    def getNodeByName(self, teamName):
        for i in self.nodeList:
            if i.getAbbreviation() == teamName:
                return i

    def addDirectional(self, node1, node2):
        node1.addChildren(node2)
        node2.setParent(node1)

    def generateGraph(self):
        graph = nx.Graph()
        for i in self.nodeList:
            if i in self.edgeDict.keys():
                node2, node3 = self.edgeDict[i]
                graph.add_edge(str(i), str(node2))
                graph.add_edge(str(i), str(node3))
        plt.clf()
        values = []
        for team in graph.nodes:
            node = self.getNodeByName(team)
            if node.getPot() == 1:
                values.append('red')
            elif node.getPot() == 2:
                values.append('yellow')
            elif node.getPot() == 3:
                values.append('purple')
            else:
                values.append('blue')
        plt.figure(figsize=(10, 10))
        nx.draw_networkx(graph, node_color=values, with_labels=True, font_color='white', node_size=900)
        plt.savefig(self.path)
        myImage = Image.open(self.path)
        img = ImageTk.PhotoImage(myImage)
        self.imageLabel = Label(self.graph_frame, image=img)
        self.imageLabel.image = img
        self.imageList.append(img)
        self.imageLabel.pack(side="bottom", fill="both", expand="yes")
        self.createPlaceForGroups()
        self.graph_frame.pack()
