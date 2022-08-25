<img align="right" src="./img/logo.png" width="192" />
<h1 align="left">Accomdemy RV32I CPU</h1>
<p align="center">
    <img src="https://img.shields.io/github/commit-activity/m/accomdemy/accomdemy_rv32i" />
    <img src="https://img.shields.io/github/repo-size/accomdemy/accomdemy_rv32i?color=yellow&style=flat-square" />
    <img src="https://img.shields.io/discord/838422912507052062?color=green" />
</p>

# 目錄
- [關於伴伴學](#關於伴伴學)
- [關於此專案](#關於此專案)
- [架構圖](#架構圖)
- [貢獻](#貢獻)
- [更新日誌](#更新日誌)
    - [20220802](#20220802)
    - [20220804](#20220804)

# [關於伴伴學](https://hackmd.io/@accomdemy/SJsr63mkt)
伴伴學 Accomdemy 是由一群來自科技圈、新創圈、教育圈的夥伴們自發性組成的自學組織。

<h3 align="center" style="font-weight: bold;">
    "Accomdemy = Accompany + Academy！"
</h3>

我們希望透過陪伴式學習的線上分享會，讓每個想自學的人在自學的路上有趣又不孤單！

疫情肆虐全球，我們的學習模式也被迫改變，也許有些人想學習，卻不得其門而入；也許有些人想學習，經濟狀況卻不允許；也許有些人想學習，卻在成長路上感到孤單，但危機就是轉機，我們希望善用線上學習工具，透過陪伴引導的共學模式，讓「想擁有學習資源」的人不用擔心在家學習會被惰性吞沒 ，所以我們成立了「伴伴學 Accomdemy」。

我們相信教育和科技可以使人突破自我限制，讓這個世界變得更美好；而我們相信最好的學習方法來自於有動力的自主學習，所以我們號召有同樣信仰的夥伴們一起付出自己所長，讓想要學習卻不得其門而入的人能夠享受學習的趣味，即時獲得有經驗的導師 (Mentor) 指導解惑，讓學習的路上有趣又不孤單。

最後，歡迎加入[伴伴學Discord！](https://discord.com/invite/rB7sc3UMTx)

# [關於此專案](https://hackmd.io/@accomdemy/BJprQ8Xjc/)
> 提示：當前我們想要完成的目標可以在issue裡面看到。

2022的暑假，我們在線上舉辦RiscV伴學松，透過每周的活動時間，在「大家都不懂」的情況下，一起學習什麼是RiscV CPU，以及挑戰看看如何做出屬於自己的一顆CPU！

而這個專案則會是跟著伴學松一起進行，在這段暑假內會根據每個階段增加/修改專案內的Module，最終變成一顆可以在Vivado合成運行的CPU。

# 架構圖
> 更新日期：2022/8/25
<center>
    <img src="./img/cpu.svg" />
</center>

# 貢獻
<img src="https://avatars.githubusercontent.com/minexo79" height=64 /> <img src="https://avatars.githubusercontent.com/MingMingFish" height=64 /> <img src="https://avatars.githubusercontent.com/min4604" height=64 /> <img src="https://avatars.githubusercontent.com/be1ieve" height=64 />

# 更新日誌
## 20220802 
- upload by [Mingming](https://github.com/MingMingFish): alu.v / cpu.v / decoder.v / regfile.v
## 20220804
- upload by [Blackcat](https://github.com/minexo79): alu.v / cpu.v / decoder.v / regfile.v
    - 修正排版
    - 補全 R-Type & I-Type Instruction
    - 補全 IMM 功能
    - 修正 Register 的條件判斷
## 20220811
- upload by [謝祥辰](https://github.com/min4604): pc.v / inst_rom.v / MUX2to1_32bit.v
    - 新增 pc.v / inst_rom.v / MUX2to1_32bit.v
    - 修改 cpu.v / cpu_tb.v
## 20220823
- upload by [Mingming](https://github.com/MingMingFish): cpu.v / decoder.v / regfile.v / pc.v / MUX4to1_32bit.v / instr_memory.v
    - 修正/統一命名方式
    - 加入 Jamp(jal) 指令功能
    - 新增 4 to 1 MUX module
    - 模擬異常，待修正(220823)
## 20220824
- upload by [Will](https://github.com/be1ieve): MUX2to1_32bit.v / alu.v / cpu.v / decoder.v / instr_memory.v / pc.v
    - 將命名名稱統一改為與圖片相同
    - 新增 PC enable 線(pce)
    - 修改圖片(加入pce)
    - 修正 cpu.v 接線
    - 更新 MUX4to1_32bit.v (加入always block)
## 20220825
- upload by [Blackcat](https://github.com/minexo79): cpu.svg / cpu.drawio / cpu.png / decoder.v
    - 修正架構圖，放上Draw.io原始檔
    - 補回 JALR 指令