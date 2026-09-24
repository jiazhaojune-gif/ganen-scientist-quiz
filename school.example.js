/**
 * 校情题模板 · 复制成 my-school.js 后修改即可
 *
 * 用法（3 步）：
 *   1. 把这个文件复制一份，重命名为 my-school.js（和 index.html 放在同一层）
 *   2. 按下面格式替换成你自己学校的题目：校训、建校年份、校史大事、著名科学家校友、现任校长院士等
 *   3. 刷新网页 —— 页面会自动加载 my-school.js，"校情题"分区自动出现
 *
 * 为什么要单独一个文件：
 *   主仓库只放各校通用的科学家普适题。校情题每校不同，放这会污染题库；
 *   拆出来之后，你 fork 的项目永远能干净地合并上游的普适题更新。
 *
 * 字段说明：
 *   id      唯一编号，建议用 x01 / x02… 避免和普适题冲突
 *   type    single 单选 | multiple 多选 | fill 填空 | flash 简答闪卡
 *   section 固定写 "school"
 *   source  题源标注（校史馆 / 学校官网 / 往年回忆卷…）
 */
window.MY_SCHOOL_META = {
  name: "我的大学",
  tip: "把第三行改成你的学校名，下面题目全部换成你自己的校情题"
};

window.MY_SCHOOL_BANK = [
  { id: "x01", type: "fill", section: "school", source: "模板示例",
    question: "我校的校训是「______」。",
    answer: "（这里填你的校训）",
    keywords: ["校训关键词"],
    note: "校训是最容易出的填空题，务必一字不差背下来。" },

  { id: "x02", type: "fill", section: "school", source: "模板示例",
    question: "我校创建于______年。",
    answer: "（建校年份）",
    keywords: ["19", "年"],
    note: "很多学校会考建校周年：今年年份 − 建校年份 = 校庆周年数。" },

  { id: "x03", type: "single", section: "school", source: "模板示例",
    question: "下列哪位科学家是我校校友 / 曾在我校任教？（ ）",
    options: ["（选项A）", "（选项B）", "（选项C）", "（选项D）"],
    answer: 0,
    note: "建议把本校走出去的两院院士、国家最高科学技术奖得主各整理一条。" },

  { id: "x04", type: "flash", section: "school", source: "模板示例",
    question: "请用 1 分钟介绍我校的办学历史与特色学科。",
    answer: "（写成 3 个要点：① 建校背景与时间 ② 优势学科 / 国家重点实验室 ③ 近年重大科研成果）" },

  { id: "x05", type: "flash", section: "school", source: "模板示例",
    question: "我校在服务国家战略方面有哪些代表性成果？",
    answer: "（例如参与的重大工程、脱贫攻坚、西部计划、对口支援等，挑 2—3 个能讲故事的例子）" },
];
