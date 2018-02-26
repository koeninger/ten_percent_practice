#######################################################
##### Problem Description #####
Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.

#######################################################

class Solution(object):
    def isValid(self, s):
        """
        :type s: str
        :rtype: bool
        """
        chars_dict = {'(':')', '{':'}','[':']'}
        char_list = []
        for char in s:
            if char in chars_dict:
                char_list.append(char)
            else:
                if len(char_list) == 0:
                    return False
                elif chars_dict[char_list.pop()]!=char: 
                    return False
        return not char_list
