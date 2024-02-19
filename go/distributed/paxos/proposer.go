package paxos
 
type Proposer struct {
	// 服务器 id
	id int
	// 当前提议者已知的最大轮次
	round int
	// 提案编号 = (轮次, 服务器 id)
	number int
	// 接受者 id 列表
	acceptors []int
}
