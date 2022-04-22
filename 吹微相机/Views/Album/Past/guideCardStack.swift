//
//  guideCardStack.swift
//  吹微GaGa
//
//  Created by Andy Jado on 2022/4/21.
//

import SwiftUI

struct guideCardStack: View {
    
    @State private var guide: [String] = [
        """
        如果这不是您唯一一次看到我
        
        以及接下来的操作指引
        
        希望您提交一份反馈
        
        现在左划
        """,
        "右划",
        "划掉就回不来啦",
    """
    不划又看不到下一张
    😬
    """,
    """
    摄像头已经打开了,拍张照吧!
    ⬇️
    """,
        "\"为什么没有预览?\"",
        "这样你按下快门的时候注视着的是对方",
        "\"我为什么不去打个视频电话?\"",
        "🧎‍♀️",
        "\"现在呢?\"",
    """
    左下角是您最近拍的一张照片
    愉悦的震动意味着照片已经成功上传云端
    """,
        "\"🥱\"",
        "🧎‍♀️",
        "\"现在呢?\"",
    """
    划走所有卡片
    点击屏幕最上方的按钮
    刷新页面看到您自己的名字
    与您思念的Ta商定CODE
    在LOVEDONE输入Ta的名字
    退出页面
    拍照
    一次震动表示一次网络活动的完成
    点击屏幕中央的橙色按钮
    收获Ta上传的照片
    
    或者...
    """,
    """
    \"😧\"
    
    ”或者?“
    """,
    """
    划走所有卡片
    点击屏幕最上方的按钮
    刷新页面看到您自己的名字
    拍照
    等待震动
    点击屏幕中央的橙色按钮
    收获你上传的照片
    
    或者...
    """,
    """
    \"😧\"
        
    ”或者?“
    """,
    """
    划走所有卡片
    点击屏幕中央的橙色按钮
    
    你会看到...
    """,
    """
    “我会看到什么?”
    """,
    """
    刚刚30s内随机世另你(也许包括你)上传的相片
    
    (这就是为什么你可能需要一串CODE)
    
    (划完卡片你就知道CODE是啥啦!)
    """,
    """
    最后!🙇‍♀️
    """,
    """
    “等等,这个app是干嘛的?”
    """,
    """
    这..一个生活场景的还原
    """,
    """
    “什么生活场景?”
    """,
    """
    就像你在爱的人面前掐起一根蒲公英, 然后拿给Ta吹掉
    
    这种
    """,
"""
“好!最后!”
""",
"""
最后!

我知道

第一次使用确实会有些摸不到头脑

但当你收到Ta发来的照片

就像这样弹出来的时候...

""",
"“哦?怎样?”",
"""
我不知道,反正我是不会退款滴.
🏃‍♀️
""",

        
    ]
        .reversed()
    
    var body: some View {
        ZStack {
            ForEach(0..<guide.count, id: \.self) { i in
                CardView(card: guide[i], removal: {
                    withAnimation {
                        removal(at: i)
                    }
                })
                .stacked(at: i, in: guide.count)
            }
        }
        
        
    }
    func removal(at i:Int) {
        guide.remove(at: i)
    }
    struct guideCardStack_Previews: PreviewProvider {
        static var previews: some View {
            guideCardStack()
        }
    }
}
