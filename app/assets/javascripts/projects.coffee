change_name = (form_item, new_name)->
  form_item.parent().parent().find('.project-name').text(new_name)

onReady = ->
  $('.show-form').on 'click', (e)->
    e.preventDefault()
    edit_form = $(this).parent().parent().find('.edit-project-form').slideToggle()

  $('form').submit (e)->
    e.preventDefault()
    self = $(this)
    data  = project:
              name: self.find('input[name="project[name]"]').val()

    $.ajax
      type: 'put'
      url: self.attr('action')
      data: data
      dataType: 'json'
      success: (project) ->
        self.parent().slideUp()
        change_name(self, project.name)

$(document).ready(onReady)