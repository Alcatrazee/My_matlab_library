def Erase_deplicate_letters(string):
    list_str = list(string)
    for i in range(len(list_str)):
        for j in range(1,len(list_str)-i):
            if(list_str[i]==list_str[i+j]):
                list_str[i+j]=''
    return "".join(list_str)

if __name__ == '__main__':
    string = 'aaacdgfgijilijipqasjdik'
    print(Erase_deplicate_letters(string))
