# 带起点偏移的孤独跑者：58人证书研究任务

## 任务与核查版本

寻找58个互不相同的正整数速度 `v_i` 和58个有理起点 `s_i`，使

\[
\gamma(v,s)=\max_{t\in\mathbb R/\mathbb Z}\min_{1\le i\le58}\|s_i+v_it\|<\frac1{59}.
\]

`||x||` 是到最近整数的距离。运动者人数 `n` 不包括固定在原点的观察者。速度可以自由选择；原命题没有要求速度恰为 `1,...,n`。

本次固定的上游仓库为 `1337isnot1337/solved-conjectures`，commit **`75a0b27a1b3e76715a45704865454b14f8f1c63d`**（2026-11-26 08:30:01 UTC）。该版本结果目录发布18—57的40份证书，并将58—94列为剩余范围。Issue #110 的2026-11-26 03:40 UTC评论与此一致；根目录说明及较早评论中还有55—94的旧记录。开始付费探索之前，再核查最新结果目录、证书数组和开放PR，并把实际采用的commit写入日志。

- [固定版本结果与范围](https://github.com/1337isnot1337/solved-conjectures/blob/75a0b27a1b3e76715a45704865454b14f8f1c63d/results/shifted-lonely-runner-counterexamples/README.md)
- [固定版本证明及搜索记录](https://github.com/1337isnot1337/solved-conjectures/blob/75a0b27a1b3e76715a45704865454b14f8f1c63d/results/shifted-lonely-runner-counterexamples/PROOF.md)
- [发现任务 Issue #110](https://github.com/1337isnot1337/solved-conjectures/issues/110)
- [证书文件](https://github.com/1337isnot1337/solved-conjectures/blob/75a0b27a1b3e76715a45704865454b14f8f1c63d/results/shifted-lonely-runner-counterexamples/certificates.json)
- [上游精确验证器](https://github.com/1337isnot1337/solved-conjectures/blob/75a0b27a1b3e76715a45704865454b14f8f1c63d/results/shifted-lonely-runner-counterexamples/verify.py)

## 原始文献与成果范围

Blanco、Criado、Santos在[arXiv:2603.24784](https://arxiv.org/abs/2603.24784)给出5—17人的反例。Poliakova在[arXiv:2609.23952](https://arxiv.org/html/2609.23952v1)证明所有 `n>=95` 都有反例，并明确指出当时剩余的18—94范围。Zhang的[arXiv:2608.13599](https://arxiv.org/abs/2608.13599)提出逐人数及最优值方面的后续问题；不同版本的问题编号有变化，上游使用v3的Question 8.5。

这次任务推进的是已被否证猜想的逐人数边界。新找到58的一份证书，价值是补上一个公开剩余实例。若同一构造覆盖多个人数、降低全体大人数结果的起始阈值，或推出统一构造，则形成更强的数学结果。精确确定 `Gamma(n)=inf_{v,s} gamma(v,s)` 还需要对所有配置的下界，本任务优先处理存在性证书。

已发布18—54证书及搜索工具归功于 `aadrianvv`，55—57归功于 `tomdif`；仓库随后补充形式化验证。复用代码、数据和论文中的构造时，在研究记录及成果中保留这些来源。

## 本题包的已知基础与实际复验

`results/known_slr_57.json` 是上游57人证书。它的精确值为

\[
\gamma=\frac{43021}{2500000},\qquad
E:=\frac1\gamma-(n+1)\approx0.1112.
\]

本次已实际运行上游 `verify.py --quick`，40份18—57证书全部通过精确有理圆弧覆盖；另对57单独调用 `check(c, exact=True)`，复算全部相关有理极值时刻并验证覆盖。相应日志为 `results/slr_upstream_quick.log`、`results/slr_upstream_57_full.log`；`results/slr_upstream_replay_manifest.json`记录版本、源文件SHA-256、命令、退出码和本机耗时。这些日志是现有成果复现，不计作新发现。

本题包自带独立的 `verify_shifted.py`，可这样运行：

```bash
python verify_shifted.py results/known_slr_57.json
```

该检查证明 `gamma <= delta < 1/(n+1)`。输入中的 `gamma` 字段仅用于选取一个候选 `delta`；精确最大值仍由上游完整极值枚举或另一条独立论证确定。现有57人的独立覆盖结果位于 `results/slr57_independent_verification.json`。

## 搜索器最小文件集与接线

上游目录为 `results/shifted-lonely-runner-counterexamples/`。最小链式搜索所需文件如下，均应取自同一个固定commit：

| 文件 | 用途 |
|---|---|
| `search/a3chain3.py` | 从已有基础池出发，增加一个运动者并循环搜索 |
| `search/a3s.c` | 可同时改变速度与起点的热浴退火 |
| `search/hyb.py` | 顺序线性规划优化、候选有理化 |
| `search/addone.py` | 根据当前时间空隙选择新速度及起点 |
| `search/gam.py` | NumPy整数极值计算，用于搜索中的较快精确筛选 |
| `certificates.json` | 已知18—57基础池 |
| `verify.py` | 独立于搜索过程的上游标准库验证器 |
| `search/beam.py`（可选） | 为同一人数积累多个不同基础 |

依赖为 NumPy、SciPy及C编译器。`a3chain3.py`、`beam.py`内的 `HERE`、`OFF` 是原作者的绝对路径；把工作副本改成当前运行目录和证书副本。保留上游原文件、修改diff及验证器。每条并行链使用独立目录，保留自己的 `achain_*.json`、`alt_*.json` 与日志。

完成路径适配、安装依赖并进入工作目录后：

```bash
gcc -O2 -o a3s a3s.c -lm
SO=1007 MULT=0.6 VMX=4 RESET=999999 python a3chain3.py 58 58 4
```

位置参数依次为 `n_start n_end tries_per_n`。`SO`控制随机种子，`MULT`控制每次退火长度，`VMX=4`把候选速度限制在 `1,...,4n`。`RESET=999999`在短基线中暂缓自动回到前一人数生成新基础，让对照更清楚。默认脚本还可能触发精修或pin-break子运行，因此 `tries_per_n` 不等于总C程序运行次数；运行器应另外执行墙钟上限并记录实际子运行数。

使用可选beam脚本积累57人基础时，其实际参数形式是：

```bash
SO=1007 MULT=0.6 VMX=4 python beam.py 57 57 6 20
```

这里依次为 `n_start n_end target_pool_size max_tries`。这些命令是经过源码核对的调用形式；本次仅复验现有证书，尚未安装或实际运行这些搜索驱动。第一次执行先做短时profile，确认路径、输出及单次耗时。

## 首轮实验：先提高57基础，再推进58

原日志提供了一条具体经验：从薄余量56基础出发，57曾56次尝试、约2.3小时未成功；得到 `E≈0.6675` 的56基础后，下一次尝试就找到57。`E>=0.5`是可用于筛选基础的经验目标，实际延伸表现还取决于速度集和活跃约束的结构。当前57的 `E≈0.1112`，适合先改进并积累多个基础。

首轮建议控制在约2小时本地CPU预算，具体运行数由短时profile确定。API先接收 `prompts/shifted_first_round.md`，产出三个可区分的实验设计；Codex把它们实现为独立工作副本，并用同一批种子、相同CPU时间比较。计时预算用完就记录当前最优与剩余瓶颈，下一次API调用以这些新数据作为输入。

| 实验 | 具体操作 | 首轮要回答的问题 |
|---|---|---|
| 基线 | 原57证书直接延伸58，种子1007、2007、3007，固定配置与时限 | 现有程序在本机的吞吐量和最优余量是多少？ |
| 强化基础 | 从已知56池生成多个57，再重优化57；保留最好的精确余量及不同速度集 | 更强、更丰富的基础是否改善58的结果？ |
| 根据峰值改搜索 | 记录LP极大值的活跃运动者对/小簇，对参与最多的瓶颈运动者做协调更新 | 有针对性的联合更新是否优于随机三点kick？ |

每次成功只保存有理证书；接近成功的失败样本也保存速度、起点、浮点估计、精确检查所得空隙及随机种子，便于分析。保留的基础池应同时考虑 `E` 与结构差异，避免只保留同一局部最优附近的多个副本。能否延伸58以同CPU预算下的新证书或精确余量变化判断。

必要的记录字段包括 `commit`、工作副本diff、`seed`、`n`、速度上限、退火步数、温度、LP轮数、CPU/墙钟时间、估计 `E`、精确覆盖是否通过、证书路径。网格漏洞数量可作为搜索分数；最终结论以有理区间覆盖或完整极值枚举为准。上游35人实例曾出现网格上零漏洞、连续时间仍有六个窄峰的情况。

三个不同设计轮次在相同CPU预算下均无新证书、无更好的基础、无新的可验证结构解释时，结束这一条路线并整理失败包。若发现57证书满足 `gamma<1/59`，给它增加一个不同速度的运动者即可得到58反例；这是严格的padding推论。普通的 `E>0` 只证明当前人数，57直接padding到58需要57基础达到 `E>1`。

## 已有失败路线与可借用的观察

上游记录过：不同尺度的旧证书简单叠加、冻结大速度的起点为0、起点限制为二次相位或半整数/四分之一整数、截短Poliakova局部规则等路线。部分有限候选菜单已经由SAT/MILP判为不可行，另一些只达到时限。研究日志应保留这些结论的具体候选类与参数，模型若重试应指出新增了哪种自由度。

速度可变的热浴更新曾使40之后的搜索明显改善。已有41—57配置经常去掉较大素因子的速度，加入60、72、84、90、96、108、120等光滑数；这是数据中的观察，可作为提议分布，尚缺统一构造证明。另一条可探索路线是从LP的活跃约束或对偶支持识别两人、三人瓶颈，设计能破除它们的速度替换。

## 精确验收与上游范围检查

候选JSON含 `n`、互异正整数数组 `speeds`、正整数 `shift_den`、整数数组 `shift_num` 和有理数字符串 `gamma`。起点为 `shift_num[i]/shift_den`。对58候选先运行本题包的检查：

```bash
python verify_shifted.py runs/slr58/candidate.json
```

然后用固定上游 `verify.py` 中的完整接口复验：

```python
import importlib.util
import json
from pathlib import Path

verifier_path = Path("upstream/slr/verify.py")
spec = importlib.util.spec_from_file_location("slr_upstream_verify", verifier_path)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
candidate = json.loads(Path("runs/slr58/candidate.json").read_text())
ok, detail = module.check(candidate, exact=True)
print(detail)
raise SystemExit(0 if ok else 1)
```

`upstream/slr/verify.py`是示例工作路径，适配为实际固定版本位置。上游主程序还校验输入列表必须恰好包含18—57，因此新58证书使用 `check(c, exact=True)` 接口，避免把证书集范围校验与单项数学校验混在一起。该接口会同时核实精确最大值与闭圆弧覆盖。

证书发现后，再次查最新文献和PR，写明新增覆盖的人数、采用的已有方法、搜索参数及独立验收结果。若要进一步形成一般性结论，需要给出适用于全部目标参数的构造与证明。由数值峰值猜测出的规律可作为下一条研究问题保存。
