import re

# 将代码内容放在executable_code.txt中， 执行python3 main_by_file.py, 结果将会保存在mem.txt

with open("executable_code.txt", "r") as f:
    text = f.read()

import re
def tranlate(text):
    # 通过正则表达式将hex code提取出来
    hex_code_list = re.findall("([0-9a-fA-F]+):\s+([0-9a-fA-F]+)\s+(\w[^\n]+)",text)
    hex_code_list = [(int(i[0],16),)+i for i in hex_code_list]
    output_list = dict([[i,""] for i in range(0,max([i[0] for i in hex_code_list]),4)])
    for index,hex_index,hex_code,comment in hex_code_list:
        hex_code = " ".join([hex_code[j-2:j] for j in range((len(hex_code)),0,-2)])
        output_list[index] = "%s \\\\ \t %s: %s"%(hex_code,hex_index,comment) 
    # for index,hex_index, in hex_code_list:
    return "\n".join(output_list.values())

mem = tranlate(text)

with open("mem.txt", "w") as f:
    f.write(mem)

print("success!! pls check the file named mem.txt")