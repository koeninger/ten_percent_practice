#######################################################
##### Problem Description #####
#Given a sorted array, remove the duplicates in-place such that each element appear only once and return the new length.

#Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

#Example:

#Given nums = [1,1,2],

#Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively.
#It doesn't matter what you leave beyond the new length.
#######################################################

class Solution(object):
    def removeDuplicates(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        if not nums:
            return 0
        last, i = 0, 1
        while i < len(nums):
            if nums[last] != nums[i]:
                last += 1
                nums[last] = nums[i]
            i += 1
            
        return last + 1
