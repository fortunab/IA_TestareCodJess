import shutil
import os

import matplotlib
import random
import networkx as nx
import matplotlib.pyplot as plt
from networkx.drawing.nx_pydot import graphviz_layout
from PIL import ImageTk
from PIL import Image
import matplotlib.patches as mpatches

from Node import Node

matplotlib.use("TkAgg")


class BreadthFirstSearch:

    def __init__(self, graph, teamData):
        if os.path.isdir("graf_folder"):
            shutil.rmtree("graf_folder")
        self.path = "graf_folder/graf"
        os.mkdir("graf_folder")
        self.teamData = teamData
        self.init(graph)

    def init(self, graph):
        self.painter = nx.DiGraph()
        self.graph = graph
        self.groups = dict()
        self.initGroups()
        self.root = graph.getRoot()
        self.queque = list()
        self.counter = 1
        self.imageList = list()
        self.queque.append(self.root)
        self.visited = list()
        self.colors = list()
        self.paintNode(self.root, '')
        self.addInGroup(self.root)

    def initGroups(self):
        for i in range(1, 9):
            self.groups[i] = list()

    def createLegends(self):
        pot1 = mpatches.Patch(color='red', label='pot 1')
        pot2 = mpatches.Patch(color='yellow', label='pot 2')
        pot3 = mpatches.Patch(color='purple', label='pot 3')
        pot4 = mpatches.Patch(color='blue', label='pot 4')
        current = mpatches.Patch(color='cyan', label='current')
        plt.legend(handles=[pot1, pot2, pot3, pot4, current])

    def paintNode(self, node, parent):
        if self.painter.has_edge(parent, node):
            return
        tempNode = None
        if node not in self.painter.nodes:
            self.painter.add_node(node)
            if node != self.root:
                self.painter.add_edge(parent, node)
        else:
            node.numberOfCopies = node.numberOfCopies + 1
            tempNode = Node(node.getTeam() + str(node.numberOfCopies), node.getCountry(), node.getAbbreviation(),
                            node.getPot())
            tempNode.setNumberCopy(node.numberOfCopies)
            self.painter.add_node(tempNode)
            self.painter.add_edge(parent, tempNode)
            self.visited.append(tempNode)
        plt.clf()
        self.createLegends()
        if tempNode is not None:
            self.createColors(tempNode)
        else:
            self.createColors(node)
        pos = graphviz_layout(self.painter, prog="dot")
        nx.draw_networkx(self.painter, pos, with_labels=True, cmap=plt.get_cmap('viridis'), font_color='white',
                         node_color=self.colors, node_size=950)
        plt.savefig(self.path + str(self.counter))
        myImage = Image.open(self.path + str(self.counter) + ".png")
        img = ImageTk.PhotoImage(myImage)
        self.imageList.append(img)
        self.counter = self.counter + 1

    def createColors(self, node):
        self.colors.clear()
        for currentNode in self.painter.nodes:
            if currentNode == node:
                self.colors.append('cyan')
            elif currentNode.getPot() == 1:
                self.colors.append('red')
            elif currentNode.getPot() == 2:
                self.colors.append('yellow')
            elif currentNode.getPot() == 3:
                self.colors.append('purple')
            else:
                self.colors.append('blue')

    def addInGroup(self, node):
        groupNr = [1, 2, 3, 4, 5, 6, 7, 8]
        while True:
            randomNr = random.choice(groupNr)
            countryFlag = False
            currentGroup = self.groups[randomNr]
            if len(currentGroup) == 4:
                groupNr.remove(randomNr)
                continue
            for team in currentGroup:
                if team.getPot() == node.getPot() or team.getCountry() == node.getCountry():
                    countryFlag = True
                    break
            if not countryFlag:
                currentGroup.append(node)
                break

        currentGroup = list()
        for group in self.groups.keys():
            currentGroup.append("Group " + str(group) + ":\n")
            for team in self.groups[group]:
                currentGroup.append(team.getTeam() + " " + team.getCountry() + "\n")
        self.teamData.append(currentGroup)

    def BFS(self):
        while len(self.queque) != 0:
            currentNode = self.queque[0]
            listChildren = currentNode.getChildrens()
            for node in listChildren:
                self.paintNode(node, currentNode)
                if node not in self.queque and node not in self.visited:
                    self.queque.append(node)
                    self.addInGroup(node)
            self.queque.remove(currentNode)
            self.visited.append(currentNode)
        return self.imageList
