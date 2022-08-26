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

from main_by_file import tranlate

mem = tranlate(text)
print(mem)


# 运行之后结果如下
"""
00 60 04 13
00 90 04 93
00 94 05 33
00 60 04 13
00 90 04 93
00 94 05 33
"""