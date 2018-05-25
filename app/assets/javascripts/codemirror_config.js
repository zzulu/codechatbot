document.addEventListener("turbolinks:load", function(e){

  // Tab to 2 spaces
  // function betterTab(cm) {
  //   if (cm.somethingSelected()) {
  //     cm.indentSelection("add");
  //   } else {
  //     cm.replaceSelection(cm.getOption("indentWithTabs")? "\t":
  //       Array(cm.getOption("indentUnit") + 1).join(" "), "end", "+input");
  //   }
  // }

  // Bots New & Edit
  // var textarea = document.getElementById('code_editor')
  // if(textarea != undefined){
  //   var editor = CodeMirror.fromTextArea(textarea, {
  //     lineNumbers: true,
  //     mode: 'ruby',
  //     theme: 'monokai',
  //     extraKeys: { Tab: betterTab }
  //   });

  //   editor.on("change", function(cm){
  //     $("#bot_response").html(cm.getValue());
  //   })
  // }

  // Bots index
  $(".readonly_code").each(function(){
    var readonly_editor = CodeMirror.fromTextArea(this, {
      lineNumbers: true,
      mode: 'ruby',
      theme: 'monokai'
    });
    readonly_editor.setOption("readOnly", true)
  })

  // $(".run_code").on("click", function(){
  //   var code = $(".code-to-run").val()
  //   $.ajax({
  //     url: "/bots/run_code.json",
  //     type: "POST",
  //     dataType:"JSON",
  //     data: {
  //       code: code
  //     },
  //     success: function(data) {
  //       $(".result").html(data.result)
  //     }
  //   })

  // })
})
    
