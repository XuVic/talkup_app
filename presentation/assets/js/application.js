console.log("test2")
issue_id = top.glob.replace(/\s+/g, "")
console.log(issue_id)
var anonymous = $("#anonymous").html()
var can_remove = $("#can_remove").html()

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
        if(anonymous == 'false') {
            console.log('anonymous false')
            action = action.concat(' <span class="commenter">'+ comment.commenter.username +'</span>')
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

$(document).on('click', '#add_collaboraotrs', function () {
    console.log('add_collaborators')
    collaborators = $("#collaborators_username").val()
    console.log(collaborators)
    var username = collaborators.split(",")
    console.log(username)
    data = {
        issue_id: issue_id,
        collaborators: {
            collaborators: username
        }
    }
    console.log(data)
    $.post('/issue/collaborators', data, function (result) {
        console.log(result);
        collaborators = JSON.parse(result).collaborators
        if (collaborators == null) {
            alert('collaborator username error!')
        }
        else{
                   for (i = 0; i < collaborators.length; i++) {
                       console.log(collaborators[i].username)
                       var collaborator_element = '<li id="' + collaborators[i].username + '" class="list-group-item"><span>' + collaborators[i].username + '</span>'
                       var action = ''
                       if (can_remove == 'true') {
                           action = '<input type="button" value="remove" class="btn btn-primary remove_collaborators">'
                       }
                       collaborator_element = collaborator_element.concat(action + '</li>')
                       $("#collaborators_list").append(collaborator_element)
                   }
        }

    });
       $("#collaborators_username").val("")
});


$(document).on('click', '.remove_collaborators', function () {
    console.log('remove_collaborators')
    var collaborator = $(this).parent().children().html()
    console.log(collaborator)
    data = {
        issue_id: issue_id,
        collaborator: collaborator
    }
    $.post('/issue/collaborators/delete', data, function (result) {
        console.log(result);
        collaborator = JSON.parse(result)
        $("#" + collaborator.username).remove();
    });
});


$(document).on('click', '.remove_collaborators', function () {
    console.log('remove_collaborators')
    var collaborator = $(this).parent().children().html()
    console.log(collaborator)
    data = {
        issue_id: issue_id,
        collaborator: collaborator
    }
    $.post('/issue/collaborators/delete', data, function (result) {
        console.log(result);
        collaborator = JSON.parse(result)
        $("#" + collaborator.username).remove();
    });
});

$(document).on('click', '.btn-feedback', function () {
    var feedback = $(this).html()
    console.log(feedback)
    var comment_id = $(this).parent().parent().parent().attr('id')
    console.log(issue_id)
    var data = {
        comment_id: comment_id,
        feedback_data: {description: feedback}
    }
    console.log(data)
    $.post('/comment/feedback', data, function (result) {
        console.log(result);
        var feedback_description = JSON.parse(result).description
        var feedback = $("#" + comment_id + "_" + feedback_description).html()
        var feedback_no = parseInt(feedback) + 1
        console.log(String(feedback_no))
        $("#" + comment_id + "_" + feedback_description).html(String(feedback_no))
    });
});