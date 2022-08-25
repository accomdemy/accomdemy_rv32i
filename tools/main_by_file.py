import re

# 将代码内容放在executable_code.txt中， 执行python3 main_by_file.py, 结果将会保存在mem.txt

with open("executable_code.txt", "r") as f:
    text = f.read()

# 通过正则表达式将hex code提取出来
hex_code_list = re.findall(":\s+([0-9a-fA-F]+)\s+",text)
# 将hex code将转换为mem格式
mem = ["%s %s %s %s"%(i[:2],i[2:4],i[4:6],i[6:]) for i in hex_code_list]
mem_text = ("\n".join(mem))


with open("mem.txt", "w") as f:
    f.write(mem_text)

print("success!! pls check the file named mem.txt")