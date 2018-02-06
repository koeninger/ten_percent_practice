#######################################################
##### Problem Description #####
#Given a string, find the length of the longest substring without repeating characters.

#Examples:

#Given "abcabcbb", the answer is "abc", which the length is 3.

#Given "bbbbb", the answer is "b", with the length of 1.

#Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

######################################################

class Solution(object):
    def lengthOfLongestSubstring(self, s):
        """
        :type s: str
        :rtype: int
        """
        temp = []
        length = 0
        for i in s:
            if i not in temp:
                temp.append(i)
            else:
                if len(temp) > length:
                    length = len(temp)
                temp =temp[temp.index(i)+1:]
                temp.append(i)
        return max(len(temp), length)
