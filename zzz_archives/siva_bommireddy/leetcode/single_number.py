#######################################################
##### Problem Description #####

# Given an array of integers, every element appears twice except for one. Find that single one.

# Note:
# Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

#######################################################

# Submission -1 (Not Accepted, Exceeded Time Limit)

class Solution(object):
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        stack = []
        for i in nums:
            if i not in stack:
                stack.append(i)
            else:
                stack.remove(i)
        return stack[0]

# Submission -2 (Accepted)

class Solution(object):
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        stack = {}
        for i in nums:
            if i in stack:
                stack.pop(i)
            else:
                stack[i] = 1
        return stack.popitem()[0]

# SUbmission -3 (Accepted)

class Solution(object):
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        return 2*sum(set(nums)) - sum(nums)
