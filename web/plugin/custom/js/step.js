var count = 0;
function changes(){
    if(count === 0){
        count ++;
        $('#wizard3').steps({
            headerTag: 'h3',
            bodyTag: 'section',
            autoFocus: true,
            titleTemplate: '<span class="number">#index#</span> <span class="title">#title#</span>',

            onFinishing: function (event, currentIndex) {
                alert('finishing');
                return false; },
            onFinished: function (event, currentIndex) {
                alert('finished');
            },
            labels: {
                cancel: "取消",
                current: "当前步骤:",
                pagination: "分页",
                finish: "交卷",
                next: "下一题",
                previous: "上一题",
                loading: "加载中 ..."
            }
        });
    }
}

$('#container').bind("DOMNodeInserted", changes);

