### 问题
 优化项目中多个alertView异步无序乱弹，不该弹的时候乱弹，该在最上面的时候可能又被其它弹出的view遮挡等等....

### 使用规则 
1. 自定义view,请继承 ```ZZBaseAlertView```
2. 在弹出自定义view的弹出方法中，执行``` [super zz_base_show]```,只有执行此方法，才会把当前的自定义view添加至windown,并交给```ZZAlertViewManager```来管理。如果需要弹出动画，请在上述方法之后调用自己的动画。
3. 在弹出自定义view的消失方法中，执行``` [super zz_base_dismiss]```,只有执行此方法，才会把当前的自定义view自windown上移除,并由```ZZAlertViewManager```来删除相关缓存。如果需要动画，可以动画完成的时候，调用此法。

***注意，如果需要动画开始，动画完成的相关回调，请自行在自定义view的动画执行的合适时机，自行完成***





