import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/quick_click_cubit.dart';
import 'view.dart';

class QuickClickPage extends StatelessWidget {
  const QuickClickPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.orange, Colors.blue])),
        child: Center(
          child: BlocProvider(
            create: (context) => QuickClickCubit(),
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '点击开始后，下面图片变化瞬间点击图片',
                    style: TextStyle(fontSize: 25, color: Colors.indigo),
                  ),
                  const Text(
                    '1秒=1000毫秒',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Builder(builder: (context) {
                    var state = context.watch<QuickClickCubit>().state;

                    return GestureDetector(
                      onTapDown: (tapDetails) =>
                          context.read<QuickClickCubit>().end(),
                      child: Container(
                          width: 324,
                          height: 324,
                          color: Colors.grey,
                          child: state.isDisplay
                              ? Image.asset(
                                  'images/labixiaoxin.jfif',
                                )
                              : null),
                    );
                  }),
                  const Padding(padding: EdgeInsets.all(8)),
                  Row(
                    children: [
                      FutureBuilder(
                          future: precacheImage(
                              const AssetImage('images/labixiaoxin.jfif'),
                              context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              var state =
                                  context.watch<QuickClickCubit>().state;

                              if (state.status == QuickClickStatus.running) {
                                return Container(
                                  width: 150,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: const Text('准备点击！'),
                                );
                              }
                              return !state.isDisplay
                                  ? ElevatedButton(
                                      style: const ButtonStyle(
                                          fixedSize: MaterialStatePropertyAll(
                                              Size(150, 50))),
                                      onPressed: () => context
                                          .read<QuickClickCubit>()
                                          .start(),
                                      child: const Text('开始',
                                          style: TextStyle(fontSize: 20)))
                                  : Container(
                                      width: 150,
                                      height: 50,
                                    );
                            }

                            return const CircularProgressIndicator.adaptive();
                          }),
                      const Padding(padding: EdgeInsets.all(8)),
                      Builder(builder: (context) {
                        return ElevatedButton(
                            style: const ButtonStyle(
                                fixedSize:
                                    MaterialStatePropertyAll(Size(150, 50))),
                            onPressed: () =>
                                context.read<QuickClickCubit>().clear(),
                            child: const Text('清除成绩',
                                style: TextStyle(fontSize: 20)));
                      })
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  const SizedBox(
                      width: 300, height: 200, child: ScoreBoardView())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
