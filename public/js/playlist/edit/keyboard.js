document.onkeydown = function(e) {
    if(!drawInfo.operRect) return;
    if(document.activeElement && (document.activeElement.nodeName.toLowerCase() == 'input' ||
        document.activeElement.nodeName.toLowerCase() == 'textarea' ||
        document.activeElement.nodeName.toLowerCase() == 'button')) return;

    e = e || window.event;
    switch (e.keyCode) {
        case 8:
            if((drawInfo.operRect.constructor == TextRect || drawInfo.operRect.constructor.superClass == TextRect)
                && $('textarea:focus').length > 0) return;
            removeSelectedRect();
            cancelDefaultEvent(e);
            break;

        case 13:
            stroke(drawInfo.operRect);
            clearTempCvs();
            $('#detailarea').empty();
            break;

        case 37: moveRectByKeyboard('left', e); break;
        case 38: moveRectByKeyboard('up', e); break;
        case 39: moveRectByKeyboard('right', e); break;
        case 40: moveRectByKeyboard('down', e); break;
        default : break;

    }
}


function  moveRectByKeyboard(moveFlag, e) {
    if(!drawInfo.operRect) return;
    switch (moveFlag) {
        case 'up':
            drawInfo.operRect.top -= 1/10 * GRIDEWIDTH;
            drawInfo.operRect.bottom -= 1/10 * GRIDEWIDTH;
            break;

        case 'down':
            drawInfo.operRect.top += 1/10 * GRIDEWIDTH;
            drawInfo.operRect.bottom += 1/10 * GRIDEWIDTH;
            break;

        case 'left':
            drawInfo.operRect.left -= 1/10 * GRIDEWIDTH;
            drawInfo.operRect.right -= 1/10 * GRIDEWIDTH;
            break;

        case 'right':
            drawInfo.operRect.left += 1/10 * GRIDEWIDTH;
            drawInfo.operRect.right += 1/10 * GRIDEWIDTH;
            break;

        default : break;
    }

    renderUpdate();
}