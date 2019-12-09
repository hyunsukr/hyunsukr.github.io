# multiAgents.py
# --------------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


from util import manhattanDistance
from game import Directions
import random, util

from game import Agent

class ReflexAgent(Agent):
    """
    A reflex agent chooses an action at each choice point by examining
    its alternatives via a state evaluation function.

    The code below is provided as a guide.  You are welcome to change
    it in any way you see fit, so long as you don't touch our method
    headers.
    """


    def getAction(self, gameState):
        """
        You do not need to change this method, but you're welcome to.

        getAction chooses among the best options according to the evaluation function.

        Just like in the previous project, getAction takes a GameState and returns
        some Directions.X for some X in the set {NORTH, SOUTH, WEST, EAST, STOP}
        """
        # Collect legal moves and successor states
        legalMoves = gameState.getLegalActions()

        # Choose one of the best actions
        scores = [self.evaluationFunction(gameState, action) for action in legalMoves]
        bestScore = max(scores)
        bestIndices = [index for index in range(len(scores)) if scores[index] == bestScore]
        chosenIndex = random.choice(bestIndices) # Pick randomly among the best

        "Add more of your code here if you want to"

        return legalMoves[chosenIndex]

    def evaluationFunction(self, currentGameState, action):
        """
        Design a better evaluation function here.

        The evaluation function takes in the current and proposed successor
        GameStates (pacman.py) and returns a number, where higher numbers are better.

        The code below extracts some useful information from the state, like the
        remaining food (newFood) and Pacman position after moving (newPos).
        newScaredTimes holds the number of moves that each ghost will remain
        scared because of Pacman having eaten a power pellet.

        Print out these variables to see what you're getting, then combine them
        to create a masterful evaluation function.
        """
        # Useful information you can extract from a GameState (pacman.py)
        successorGameState = currentGameState.generatePacmanSuccessor(action)
        newPos = successorGameState.getPacmanPosition()
        newFood = successorGameState.getFood()
        newGhostStates = successorGameState.getGhostStates()
        newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]
        cost = 0
        counterfood = 0
        foodlist = currentGameState.getFood().asList()
        if len(foodlist) == 0:
            return 999999
        else:
            closest_distance = 999999
            for food in foodlist:
                x, y = food
                if newFood[x][y] == True:
                    counterfood = counterfood + 1
                    if abs(util.manhattanDistance(newPos, food)) < closest_distance:
                        closest_distance = abs(util.manhattanDistance(newPos, food))
            distance_to_ghost = abs(util.manhattanDistance(newPos, newGhostStates[0].getPosition()))
            if distance_to_ghost == 0.0:
                distance_to_ghost = -1000
            if counterfood == 0:
                return 999999
            cost = successorGameState.getScore() + (1/closest_distance) + (1/(distance_to_ghost) * -5) + (1/counterfood)
        return (cost)

        # util.raiseNotDefined()

        "*** YOUR CODE HERE ***"
        # return successorGameState.getScore()

def scoreEvaluationFunction(currentGameState):
    """
    This default evaluation function just returns the score of the state.
    The score is the same one displayed in the Pacman GUI.

    This evaluation function is meant for use with adversarial search agents
    (not reflex agents).
    """
    return currentGameState.getScore()

class MultiAgentSearchAgent(Agent):
    """
    This class provides some common elements to all of your
    multi-agent searchers.  Any methods defined here will be available
    to the MinimaxPacmanAgent, AlphaBetaPacmanAgent & ExpectimaxPacmanAgent.

    You *do not* need to make any changes here, but you can if you want to
    add functionality to all your adversarial search agents.  Please do not
    remove anything, however.

    Note: this is an abstract class: one that should not be instantiated.  It's
    only partially specified, and designed to be extended.  Agent (game.py)
    is another abstract class.
    """

    def __init__(self, evalFn = 'scoreEvaluationFunction', depth = '2'):
        self.index = 0 # Pacman is always agent index 0
        self.evaluationFunction = util.lookup(evalFn, globals())
        self.depth = int(depth)

class MinimaxAgent(MultiAgentSearchAgent):
    """
    Your minimax agent (question 2)
    """
    def getAction(self, gameState):
        """
        Returns the minimax action from the current gameState using self.depth
        and self.evaluationFunction.

        Here are some method calls that might be useful when implementing minimax.

        gameState.getLegalActions(agentIndex):
        Returns a list of legal actions for an agent
        agentIndex=0 means Pacman, ghosts are >= 1

        gameState.generateSuccessor(agentIndex, action):
        Returns the successor game state after an agent takes an action

        gameState.getNumAgents():
        Returns the total number of agents in the game

        gameState.isWin():
        Returns whether or not the game state is a winning state

        gameState.isLose():
        Returns whether or not the game state is a losing state
        """
        "*** YOUR CODE HERE ***"

        agent = 0
        def max_val(gameState, depth):
            if gameState.isWin():
                return gameState.getScore()
            if gameState.isLose():
                return gameState.getScore()
            actions = gameState.getLegalActions(agent)
            scores = []
            for action in actions:
                scores.append(min_val(gameState.generateSuccessor(agent, action), depth, 1))
            max_score = max(scores)
            max_index = scores.index(max_score)
            max_action = actions[max_index]
            if depth != 0:
                return max_score
            else:
                return max_action

        def min_val(gameState, depth, agent):
            if gameState.isLose():
                return gameState.getScore()
            if gameState.isWin():
                return gameState.getScore()
            newagent = agent + 1
            if agent == gameState.getNumAgents() - 1:
                newagent = agent
            actions = gameState.getLegalActions(agent)
            scores = []
            if agent == newagent:
                if depth == self.depth - 1:
                    for action in actions:
                        scores.append(self.evaluationFunction(gameState.generateSuccessor(agent, action)))
                else:
                    for action in actions:
                        scores.append(max_val(gameState.generateSuccessor(agent, action), depth + 1))
            else:
                for action in actions:
                    scores.append(min_val(gameState.generateSuccessor(agent, action), depth, newagent))
            return min(scores)
        return max_val(gameState, 0)

        # util.raiseNotDefined()

class AlphaBetaAgent(MultiAgentSearchAgent):
    """
    Your minimax agent with alpha-beta pruning (question 3)
    """

    def getAction(self, gameState):
        """
        Returns the minimax action using self.depth and self.evaluationFunction
        """
        "*** YOUR CODE HERE ***"
        agent = 0
        def max_val(state, depth, alpha, beta):
            if state.isWin():
                return state.getScore()
            if state.isLose():
                return state.getScore()
            actions = state.getLegalActions(agent)
            scores = [-999999,-999999]
            action_to_take = Directions.STOP
            for action in actions:
                successorstate = state.generateSuccessor(agent, action)
                temp_score = min_val(successorstate, depth, 1, alpha, beta)
                if temp_score > scores[0]:
                    newset = [temp_score]
                    newset.append(scores[1])
                    scores = newset
                    action_to_take = action
                alpha = max(alpha, scores[0])
                if beta < scores[0]:
                    return scores[0]
            if depth != 0:
                return scores[0]
            else:
                return action_to_take

        def min_val(state, depth, agent, alpha, beta):
            if state.isLose():
                return state.getScore()
            if state.isWin():
                return state.getScore()
            newagent = agent + 1
            if agent == state.getNumAgents() - 1:
                newagent = agent
            actions = state.getLegalActions(agent)
            scores = [999999,999999]
            for action in actions:
                if newagent == agent: 
                    if depth == self.depth - 1:
                        temp_score = self.evaluationFunction(state.generateSuccessor(agent, action))
                        if temp_score < scores[0]:
                            newset = [temp_score]
                            newset.append(scores[1])
                            scores = newset
                            action_to_take = action
                    else:
                        temp_score = max_val(state.generateSuccessor(agent, action), depth + 1, alpha, beta)
                        if temp_score < scores[0]:
                            newset = [temp_score]
                            newset.append(scores[1])
                            scores = newset
                            action_to_take = action
                else:
                    temp_score = min_val(state.generateSuccessor(agent, action), depth, newagent, alpha, beta)
                    if temp_score < scores[0]:
                        newset = [temp_score]
                        newset.append(scores[1])
                        scores = newset
                        action_to_take = action
                beta = min(beta, scores[0])
                if scores[0] < alpha:
                    return scores[0]
            return scores[0]
        return max_val(gameState, 0, -999999, 999999)

class ExpectimaxAgent(MultiAgentSearchAgent):
    """
      Your expectimax agent (question 4)
    """

    def getAction(self, gameState):
        """
        Returns the expectimax action using self.depth and self.evaluationFunction

        All ghosts should be modeled as choosing uniformly at random from their
        legal moves.
        """
        "*** YOUR CODE HERE ***"
        agent = 0
        def max_val(gameState, depth):
            if gameState.isWin():
                return gameState.getScore()
            if gameState.isLose():
                return gameState.getScore()
            actions = gameState.getLegalActions(agent)
            scores = []
            for action in actions:
                scores.append(min_val(gameState.generateSuccessor(agent, action), depth, 1))
            max_score = max(scores)
            max_index = scores.index(max_score)
            max_action = actions[max_index]
            if depth != 0:
                return max_score
            else:
                return max_action
        def min_val(gameState, depth, agent):
            if gameState.isLose():
                return gameState.getScore()
            if gameState.isWin():
                return gameState.getScore()
            newagent = agent + 1
            if agent == gameState.getNumAgents() - 1:
                newagent = agent
            actions = gameState.getLegalActions(agent)
            scores = []
            if agent == newagent:
                if depth == self.depth - 1:
                    for action in actions:
                        scores.append((1/len(actions)) * self.evaluationFunction(gameState.generateSuccessor(agent, action)))
                else:
                    for action in actions:
                        scores.append((1/len(actions)) * max_val(gameState.generateSuccessor(agent, action), depth + 1))
            else:
                for action in actions:
                    scores.append((1/len(actions)) * min_val(gameState.generateSuccessor(agent, action), depth, newagent))
            totalscore = 0
            for score in scores:
                totalscore = totalscore + score
            return totalscore
        return max_val(gameState, 0)
def betterEvaluationFunction(currentGameState):
    """
    Your extreme ghost-hunting, pellet-nabbing, food-gobbling, unstoppable
    evaluation function (question 5).

    DESCRIPTION: <write something here so we know what you did>
    """
    "*** YOUR CODE HERE ***"
    newPos = currentGameState.getPacmanPosition()
    newFood = currentGameState.getFood()
    newGhostStates = currentGameState.getGhostStates()
    newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]
    cost = currentGameState.getScore()
    minDist = 0
    ghostNum = 0
    distance = manhattanDistance(newPos, newGhostStates[0].getPosition())
    for pos in newGhostStates:
        if minDist < distance:
            if pos.scaredTimer <= 0:
                ghostNum -= 100.0 / distance
            else:
                ghostNum += 100.0 / distance
        distance = manhattanDistance(newPos, pos.getPosition())
    foodDistance = []
    for food in newFood.asList():
        distance = manhattanDistance(newPos, food)
        foodDistance.append(distance)
    addScore = cost + ghostNum
    cost = addScore
    cost = currentGameState.getScore() + (1/len(foodDistance)) + ghostNum + (1 / len(newFood.asList()))
    return cost

# Abbreviation
better = betterEvaluationFunction
