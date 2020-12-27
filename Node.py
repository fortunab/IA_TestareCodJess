class Node:
    def __init__(self, teamName, country, abbreviation, pot):
        self.teamName = teamName
        self.country = country
        self.abbreviation = abbreviation
        self.pot = pot
        self.parent = None
        self.childrens = list()
        self.copyNumber = 0
        self.numberOfCopies = 0
        self.visited = False

    def getNodeName(self):
        return self.nodeName

    def getTeam(self):
        return self.teamName

    def getPot(self):
        return int(self.pot)

    def getAbbreviation(self):
        return self.abbreviation

    def getCountry(self):
        return self.country

    def getChildrens(self):
        return self.childrens

    def getParent(self):
        return self.parent

    def setParent(self, parent):
        self.parent = parent

    def setPot(self, pot):
        self.pot = pot

    def setTeam(self, team):
        self.teamName = team

    def setNumberCopy(self, nr):
        self.copyNumber = nr

    def getNumberCopy(self):
        return self.copyNumber

    def addChildren(self, children):
        self.childrens.append(children)

    def addChildrens(self, childrens):
        self.childrens.extend(childrens)

    def __str__(self):
        return self.abbreviation

    def __eq__(self, obj):
        return isinstance(obj, Node) and obj.teamName == self.teamName and self.country == obj.country

    def __hash__(self):
        return hash((self.teamName, self.country))
