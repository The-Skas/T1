
def funnel(word, compare):
	for i,x in enumerate(word):
	 if(word[:i]+ word[i+1:] == compare):
	    return True
	return False


print(funnel("hello", "hel"))

print(funnel("hello", "hell"))
