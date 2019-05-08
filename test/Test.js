var DogeCoinToken = artifacts.require("DogeCoinToken");
var BatchTransfer = artifacts.require("BatchTransfer");
var dogecoinToken;
var batchTransfer;

contract('CreateProofFactory', async (accounts) => {
    it('创建DogeCoinToken', async () => {

        dogecoinToken = await DogeCoinToken.new({
            from: accounts[0]
        });

        // 查询余额
        console.log(await dogecoinToken.balanceOf(accounts[0]));
    })

    it('批量转账', async () => {
        batchTransfer = await BatchTransfer.new(accounts[8]);

        // 先获取批准
        await dogecoinToken.approve(batchTransfer.address, 600, {
            from: accounts[0]
        });

        batchTransfer.batchTransferToken(dogecoinToken.address, [accounts[1], accounts[2], accounts[3]], [100, 200, 300]);

        // 查询余额
        console.log(await dogecoinToken.balanceOf(accounts[0]));
        console.log(await dogecoinToken.balanceOf(accounts[1]));
        console.log(await dogecoinToken.balanceOf(accounts[2]));
        console.log(await dogecoinToken.balanceOf(accounts[3]));

    })
})