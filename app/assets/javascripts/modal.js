$(document).on("turbolinks:load", function(){
  const open = document.getElementById("open");
  const close = document.getElementById("close");
  const modal = document.getElementById("modal");
  const mask = document.getElementById("mask");

  open.addEventListener("click", function() {
    modal.classList.remove("hidden");
    mask.classList.remove("hidden");
    const canvas = document.createElement("canvas");
    const ctx = canvas.getContext("2d");
    $(".hidden__image__slider").before(canvas);
    
    const image = new Image();
    image.src = 'https://ja.wikipedia.org/static/images/project-logos/jawiki.png'
    image.crossOrigin = "anonymous"
    //編集する画像を取得
    image.onload = () => {
      canvas.height = 380;
      canvas.width = 380;
      ctx.drawImage(image, 0, 0, 114, 116, 10, 10, 330, 330);
    };

    image.onerror = () => {
      console.log("画像の読み込み失敗")
    };

    const slider = document.getElementById("zoom-slider");
    slider.value = 1;
    slider.min = 1;
    slider.max = 2;
    slider.step = 0.01;
    slider.name = "scale"

    slider.addEventListener("input", e => {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      const scale = e.target.value;
      ctx.scale(scale, scale);
      ctx.drawImage(image, 0, 0, 114, 116, 10, 10, 330, 330);
      ctx.scale(1 / scale, 1 / scale);
    })

    

    let isDragging = false;
    let start = {
      x: 0,
      y: 0
    };

    let diff = {
      x: 0,
      y: 0
    };

    let end = {
      x: 0,
      y: 0
    }
    const redraw = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.drawImage(image, diff.x, diff.y)
    };
    canvas.addEventListener('mousedown', event => {
      isDragging = true;
      start.x = event.clientX;
      start.y = event.clientY;

    });
    canvas.addEventListener('mousemove', event => {
      if (isDragging){
        diff.x = (event.clientX - start.x) + end.x;
        diff.y = (event.clientY - start.y) + end.y;
        redraw();
      }
    });
    canvas.addEventListener('mouseup', event => {
      isDragging = false;
      end.x = diff.x;
      end.y = diff.y;
    })
  });
  close.addEventListener("click", function(){
    modal.classList.add("hidden");
    mask.classList.add("hidden");
  });
  mask.addEventListener("click", function(){
    modal.classList.add("hidden");
    mask.classList.add("hidden");
  });
  
  
  
})
