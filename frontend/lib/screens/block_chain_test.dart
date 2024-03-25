import 'package:flutter/material.dart';
import 'package:frontend/models/block_chain_model.dart';
import 'package:provider/provider.dart';
import 'package:frontend/view_models/block_chain/block_chain_viewmodel.dart';

class BlockChainTest extends StatelessWidget {
  const BlockChainTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BlockChainViewModel(BlockChainModel(), ),
        child: Consumer<BlockChainViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text('블록체인 테스트'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final response = await viewModel.deployContract();
                        debugPrint('컨트랙트 배포 결과: $response');
                      },
                      child: Text('컨트랙트 배포'),
                    ),
                    Text('값: ${viewModel.num}'),
                    TextFormField(
                      decoration: InputDecoration(labelText: '값 입력'),
                      onChanged: (value) {viewModel.setNum(int.parse(value));
                      debugPrint('입력값: $value');}
                    ),
                    ElevatedButton(
                      onPressed: () async {
                         await viewModel.sendTransaction('store', [BigInt.from(viewModel.num *3)]).then((res) async{
                          await viewModel.retrieve();
                          debugPrint('retrieve 함수 호출 결과: ${viewModel.newNum}, $res');
                        });
                        // debugPrint('store 함수 호출 결과: $response');
                        
                      },
                      child: Text('store 함수 호출'),
                    ),
                    Text('Current value : ${viewModel.newNum}'),
                    
                    ElevatedButton(
                      onPressed: () async {
                        final response = await viewModel.retrieve();
                        debugPrint('retrieve 함수 호출 결과: ${viewModel.newNum}, $response');
                      },
                      child: Text('retrieve 함수 호출'),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}