# valueIterationAgents.py
# -----------------------
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


# valueIterationAgents.py
# -----------------------
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


import mdp, util

from learningAgents import ValueEstimationAgent
import collections

class ValueIterationAgent(ValueEstimationAgent):
    """
        * Please read learningAgents.py before reading this.*

        A ValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs value iteration
        for a given number of iterations using the supplied
        discount factor.
    """
    def __init__(self, mdp, discount = 0.9, iterations = 100):
        """
          Your value iteration agent should take an mdp on
          construction, run the indicated number of iterations
          and then act according to the resulting policy.

          Some useful mdp methods you will use:
              mdp.getStates()
              mdp.getPossibleActions(state)
              mdp.getTransitionStatesAndProbs(state, action)
              mdp.getReward(state, action, nextState)
              mdp.isTerminal(state)
        """
        self.mdp = mdp
        self.discount = discount
        self.iterations = iterations
        self.values = util.Counter() # A Counter is a dict with default 0
        self.runValueIteration()

    def runValueIteration(self):
        # Write value iteration code here
        "*** YOUR CODE HERE ***"
        for iterations in range(self.iterations):
            iteration_val = self.values.copy()
            for state in self.mdp.getStates(): 
                if not self.mdp.isTerminal(state):
                    actions = self.mdp.getPossibleActions(state)
                    Qvalues = []
                    for action in actions:
                        q_val = self.computeQValueFromValues(state, action)
                        Qvalues.append(q_val)
                    maxval = max(Qvalues)
                    iteration_val[state] = maxval
            self.values = iteration_val


    def getValue(self, state):
        """
          Return the value of the state (computed in __init__).
        """
        return self.values[state]


    def computeQValueFromValues(self, state, action):
        """
          Compute the Q-value of action in state from the
          value function stored in self.values.
        """
        "*** YOUR CODE HERE ***"
        QValue = 0
        for nextpoint, prob in self.mdp.getTransitionStatesAndProbs(state, action):
            reward = self.mdp.getReward(state, action, nextpoint)
            prev_q = QValue
            QValue = prev_q + (prob * (reward + self.discount * self.values[nextpoint]))
        return QValue


    def computeActionFromValues(self, state):
        """
          The policy is the best action in the given state
          according to the values currently stored in self.values.

          You may break ties any way you see fit.  Note that if
          there are no legal actions, which is the case at the
          terminal state, you should return None.
        """
        "*** YOUR CODE HERE ***"
        policy = {}
        for action in self.mdp.getPossibleActions(state):
            policy[action] = self.computeQValueFromValues(state, action)
        bestaction = ''
        if len(policy) > 0:
            bestaction = max(policy, key=lambda k: policy[k])
        return bestaction
       

    def getPolicy(self, state):
        return self.computeActionFromValues(state)

    def getAction(self, state):
        "Returns the policy at the state (no exploration)."
        return self.computeActionFromValues(state)

    def getQValue(self, state, action):
        return self.computeQValueFromValues(state, action)

class AsynchronousValueIterationAgent(ValueIterationAgent):
    """
        * Please read learningAgents.py before reading this.*

        An AsynchronousValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs cyclic value iteration
        for a given number of iterations using the supplied
        discount factor.
    """
    def __init__(self, mdp, discount = 0.9, iterations = 1000):
        """
          Your cyclic value iteration agent should take an mdp on
          construction, run the indicated number of iterations,
          and then act according to the resulting policy. Each iteration
          updates the value of only one state, which cycles through
          the states list. If the chosen state is terminal, nothing
          happens in that iteration.

          Some useful mdp methods you will use:
              mdp.getStates()
              mdp.getPossibleActions(state)
              mdp.getTransitionStatesAndProbs(state, action)
              mdp.getReward(state)
              mdp.isTerminal(state)
        """
        ValueIterationAgent.__init__(self, mdp, discount, iterations)

    def runValueIteration(self):
        "*** YOUR CODE HERE ***"
        states = self.mdp.getStates()
        num_states = len(states)
        print("***")
        print(self.iterations)
        for i in range(self.iterations):
            print("&&&")
            print("States: ", states)
            print("Iteration counter: ", i)
            print("Length of states array: ", num_states)
            state = states[i % num_states]
            print("The specific state: ", state)
            print("&&&")
            if self.mdp.isTerminal(state):
                continue
            else:
                values = []
                possible_actions = self.mdp.getPossibleActions(state)
                for action in possible_actions:
                    QValue = self.computeQValueFromValues(state, action)
                    values.append(QValue)
                self.values[state] = max(values)

class PrioritizedSweepingValueIterationAgent(AsynchronousValueIterationAgent):
    """
        * Please read learningAgents.py before reading this.*

        A PrioritizedSweepingValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs prioritized sweeping value iteration
        for a given number of iterations using the supplied parameters.
    """
    def __init__(self, mdp, discount = 0.9, iterations = 100, theta = 1e-5):
        """
          Your prioritized sweeping value iteration agent should take an mdp on
          construction, run the indicated number of iterations,
          and then act according to the resulting policy.
        """
        self.theta = theta
        ValueIterationAgent.__init__(self, mdp, discount, iterations)

    def runValueIteration(self):
        "*** YOUR CODE HERE ***"
        PriorityQueue = util.PriorityQueue()
        predecessors = {}
        allStates = self.mdp.getStates()
        
        for state in allStates:
            if self.mdp.isTerminal(state):
                continue
            else:
                actions = self.mdp.getPossibleActions(state)
                for action in actions:
                    transitions = self.mdp.getTransitionStatesAndProbs(state, action)
                    for nextpoint, prob in transitions:
                        if (nextpoint in predecessors):
                            cur_list = predecessors[nextpoint].copy()
                            cur_list.append(state)
                            predecessors[nextpoint] = cur_list
                        else:
                            # print("Pred with no key", predecessors)
                            # print("Point being added", nextpoint)
                            predecessors[nextpoint] = [state]
                            # predecessors[nextpoint] = {state}
                            # print("After being made", predecessors)
        for state in allStates:
            if not self.mdp.isTerminal(state):
                max_val = -1000
                actions = self.mdp.getPossibleActions(state)
                for action in actions:
                    QValue = self.computeQValueFromValues(state, action)
                    if QValue > max_val:
                        max_val = QValue
                diff = abs(QValue - self.values[state])
                PriorityQueue.update(state, - diff)
        for i in range(self.iterations):
            if PriorityQueue.isEmpty():
                break
            else:
                popped_state = PriorityQueue.pop()
                if not self.mdp.isTerminal(popped_state):
                    max_val = -1000
                actions = self.mdp.getPossibleActions(popped_state)
                for action in actions:
                    QValue = self.computeQValueFromValues(popped_state, action)
                    if QValue > max_val:
                        max_val = QValue
                self.values[popped_state] = max_val
            for p in predecessors[popped_state]:
                if not self.mdp.isTerminal(p):
                    max_val = -1000
                actions = self.mdp.getPossibleActions(p)
                for action in actions:
                    QValue = self.computeQValueFromValues(p, action)
                    if QValue > max_val:
                        max_val = QValue
                diff = abs(self.values[p] - max_val)
                if diff > self.theta:
                    PriorityQueue.update(p, -diff)
