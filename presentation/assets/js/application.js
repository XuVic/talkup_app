console.log("test")
issue_id = top.glob.replace(/\s+/g, "")
console.log(issue_id)

$('#comment').click(function(){
    comment_info = $("#comment_info").val()
    var data = {comment_data:{content: comment_info, anonymous:1}, issue_id: issue_id}
    console.log(comment_info)
    $.post("/comment", data ,
     function (result) {
        console.log(result)
        comment = JSON.parse(result)
        var comment_element = '<li class="list-group-item" id="'+ comment.id + '"  style="width: 500px" > <div class="col"> <p>' + comment.content + '</p></div>'
        var action = '<div class="col">'
        if (comment.policy.can_edit == true ) {
            action = action.concat('<input type="button" value="Edit" class="btn btn-primary comment_edit"> ')
            console.log('can_edit')
        }
        if(comment.policy.can_delete == true) {
            action = action.concat('<input type="button" value="Delete" class="btn btn-primary comment_delete">')
        }
        action = action.concat('</div>')
        comment_element = comment_element.concat(action, '</li>')
        console.log(comment_element)
        $("#comments").append(comment_element)

        $("#comment_info").val("")
    });
});

$("#clear").click(function(){
    $("#comment_info").val("")
    console.log("clear")
});

$(document).on('click', '.comment_delete', function () {
    console.log('comment_delete')
    comment_id = $(this).parent().parent().attr('id');
    data = {
        comment_id: comment_id
    }
    $.post('/comment/delete', data, function (result) {
        console.log(result);
        result = JSON.parse(result);
        $("#" + comment_id).remove();
    });
});

$(document).on('click', '.comment_edit', function () {
$(".comment_edit").click(function () {
    console.log('comment_edit')
    var comment = $(this).parent().parent().children().children().html()
    console.log(comment)
    var edit_input = '<div class="input-group mb-3"> <input id="comment_content" type="text" value="' + comment + '" class="form-control"><div class="input-group-append"><button class="btn btn-outline-secondary" type="button" id="edit_comment">Edit</div></div>'
    console.log($(this).parent().parent().attr('id'))
    comment_id = $(this).parent().parent().attr('id')
    $(this).parent().parent().html(edit_input)
    var comment_content = $("#comment_content").val()
    $("#comment_content").change(function () {
        comment_content = $(this).val()
    })
    $("#edit_comment").click(function () {
        console.log(comment_content, comment_id)
        data = {
            comment_data: {
                content: comment_content
            },
            comment_id: comment_id
        }
        $.post("/comment/edit", data, function (result) {
            console.log(result)
            comment = JSON.parse(result)
            var comment_element = ' <div class="col-5"> <p>' + comment.content + ' </p></div>'
            var action = '<div class="col">'
            if (comment.policy.can_edit == true) {
                action = action.concat('<input type="button" value="Edit" class="btn btn-primary comment_edit"> ')
                console.log('can_edit')
            }
            if (comment.policy.can_delete == true) {
                action = action.concat('<input type="button" value="Delete" class="btn btn-primary comment_delete">')
            }
            action = action.concat('</div>')
            comment_element = comment_element.concat(action)
            $("#" + comment_id).html(comment_element)
        })
    });
});

});

