import tkinter as tk
from tkinter import *
from tkinter.filedialog import askopenfilename
import ntpath

from GraphGenerator import GraphGenerator


class GraphicInterface:

    def __init__(self):
        self.root = tk.Tk()
        self.algoNames = ['BFS', 'DFS']
        self.createInterface()
        self.root.geometry("400x200")
        self.root.config(bg="#828481")
        self.root.mainloop()

    def openFileChooser(self):
        Tk().withdraw()
        self.filePath = askopenfilename()
        self.fileName = ntpath.basename(self.filePath)

        self.display.set(self.fileName)
        self.executeButton.config(state="active")

    def chooseAlgorithm(self, algName):
        self.convertFile()
        GraphGenerator(Toplevel(self.root), self.filePath, algName)

    def createInterface(self):
        self.root.title("Generare grupe UCL")
        tk.Button(self.root, text="Select Teams", command=lambda: self.openFileChooser()).grid(
            row=1, column=0, sticky=tk.W + tk.E
        )
        tk.Button(self.root,
                  text='Quit',
                  command=self.root.quit).grid(row=0,
                                               column=1,
                                               sticky=tk.W + tk.E,
                                               pady=5,
                                               padx=5
                                               )
        self.executeButton = Button(self.root, text="Create groups!",
                                    command=lambda: self.chooseAlgorithm(self.algorithm))
        self.executeButton.grid(row=2, column=0, sticky=tk.W + tk.E)
        self.executeButton.config(state="disabled")
        self.display = tk.StringVar()
        self.display.set("File path")
        self.labelFileName = tk.Entry(self.root,
                                      text=self.display, width=30)
        self.labelFileName.grid(row=0, column=0, ipady=3)
        self.labelFileName.config(state="disabled")

        self.algorithm = tk.StringVar()
        self.algorithm.set(self.algoNames[0])  # default value

        self.algoDropDown = OptionMenu(self.root, self.algorithm, *self.algoNames)
        self.algoDropDown.grid(row=1, column=1, sticky=tk.W + tk.E, padx=5)

    def convertFile(self):
        fisier = self.filePath
        f = open(fisier, 'r')
        lfile = f.read().split('\n')
        ln1 = []
        for i in lfile:
            ln1.append(i.split(" "))
        teams = []
        for echipe in ln1:
            for i in range(len(echipe)):
                if i == 2:
                    teams.append(echipe[i][:-1])
        cod = []
        for echipe in ln1:
            for i in range(len(echipe)):
                if i == 8:
                    cod.append(echipe[i][:-1])
        tara = []
        for echipe in ln1:
            for i in range(len(echipe)):
                if i == 4:
                    tara.append(echipe[i][:-1])
        palarie = []
        for echipe in ln1:
            for i in range(len(echipe)):
                if i == 6:
                    palarie.append(echipe[i][:-1])
        string = ""
        for i in range(len(teams)):
            string += teams[i] + " " + cod[i] + " " + tara[i] + " " + palarie[i] + '\n'
        g = open("Graph.txt", "w")
        self.filePath = "Graph.txt"
        g.write(string)
        g.close()
