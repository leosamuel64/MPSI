def sentenceToWords(sentence):
	liste = []
	word = ""
	for i in range (0,len(sentence)):
		if sentence[i] != " ":
			word += sentence[i]
		else :
			liste.append(word)
			word = ""


	liste.append(word)

	return liste

print(sentenceToWords("Arthur le glomorphe à rayure marche à vive allure"))
