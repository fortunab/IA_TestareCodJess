class Graph:
    def __init__(self, nodes, edges, root):
        self.nodes = nodes
        self.edges = edges
        self.root = root

    def getNodes(self):
        return self.nodes

    def getEdges(self):
        return self.edges

    def addCost(self, parent, node1, node2):
        self.edges[parent] = [node1, node2]

    def getRoot(self):
        return self.root

    def getNodeByName(self, nodeName):
        for i in self.nodes:
            if i.getNodeName() == nodeName:
                return i

    def __str__(self):
        return str(self.nodes)
