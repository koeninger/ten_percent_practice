#######################################################
##### Problem Description #####
# Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
#
# For example,
# "A man, a plan, a canal: Panama" is a palindrome.
# "race a car" is not a palindrome.

# Note:
# Have you consider that the string might be empty? This is a good question to ask during an interview.
#
# For the purpose of this problem, we define empty string as valid palindrome.

class Solution(object):
    def isPalindrome(self, s):
        """
        :type s: str
        :rtype: bool
        """
        s = "".join([c.lower() for c in s if c.isalnum()])
        i,j = 0, len(s)-1
        while i < j:
            if s[i].isalnum() and s[j].isalnum():
                if s[i] != s[j]:
                    return False
            i,j = i+1, j-1
        return True  
#######################################################
