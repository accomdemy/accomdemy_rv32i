# 在双引号的中间粘贴上executable code, 点击运行即可

text = """
00000000 <mian>:
    0:        00600413        addi x8 x0 6
    4:        00900493        addi x9 x0 9
    8:        00940533        add x10 x8 x9

0000000c <subroute>:
    c:        00600413        addi x8 x0 6
    10:        00900493        addi x9 x0 9
    14:        00940533        add x10 x8 x9
"""

import re
# 通过正则表达式将hex code提取出来
hex_code_list = re.findall(":\s+([0-9a-fA-F]+)\s+",text)
# 将hex code将转换为mem格式
mem = ["%s %s %s %s"%(i[:2],i[2:4],i[4:6],i[6:]) for i in hex_code_list]
print("\n".join(mem))

# 运行之后结果如下
"""
00 60 04 13
00 90 04 93
00 94 05 33
00 60 04 13
00 90 04 93
00 94 05 33
"""