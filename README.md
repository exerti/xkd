# xkd

A new Flutter project.

## Getting Started

### 版本选择
- flutter 3.24.3
- java 17
- gradle gradle-8.3-all

### rules
- 使用getx 的路由 和 bloc 的cubit ，state, page 模 式；
- 路由统一在routes/app_routes.dart中注册，并且导入相关的页面依赖，然后在main中使用AppRoutes.routes
- 使用build_runner，json_serializable ,在/lib/model下生成对应的.dart ,.dart.g文件
- 资源在assets中添加，在 image_const  中 添加 XKDResource 「
  static XXXX_XXX_XX = "/path"；
 」
- 资源图使用3x的图片，wepb格式
- 如果有gif，lottie 使用 flutter的lottie 或者gifView 相关的库
- 页面统一有xxxx_page.dart,xxxx_cubit.dart,xxxx_state.dart 构成 xxxx 是文件名，小驼峰

 
