state_panel_requirement =
  begin: 'panel-default'
  sent_for_review: 'panel-info'
  sent_back_for_revision: 'panel-danger'
  accepted: 'panel-success'
  complete: 'panel-primary'

change_task_view = (new_task, state, id)->
  console.log state
  console.log state_panel_requirement[state]
  a = new_task.find('a')
  p = a.parent()
  new_state = "#{location.pathname}/#{id}/new_state"
  previos_state = "#{location.pathname}/#{id}/previos_state"
  a.each( (ind, item)->
    item.remove())
  new_task.removeClass()
  new_task.addClass("panel #{state_panel_requirement[state]}")
  switch state
    when 'sent_for_review'
      p.append($('<a>',
      {
        text: "Accept"
        href: new_state
        class: "btn btn-default btn-xs change-state"
      }))
      p.append($('<a>',
      {
        text: "Send back"
        href: previos_state
        class: "btn btn-default btn-xs change-state"
      }))
    when 'sent_back_for_revision'
      p.append($('<a>',
      {
        text: "Send for review"
        href: new_state
        class: "btn btn-default btn-xs change-state"
      }))
    when 'accepted'
      p.append($('<a>',
      {
        text: "End up"
        href: new_state
        class: "btn btn-default btn-xs change-state"
      }))

change_task_place = (current_task, new_state, id)->
  new_task = $(current_task.parent().html())
  current_task.
    closest('tr').
    find(".#{new_state}").
    append(new_task)
  change_task_view(new_task, new_state, id)
  current_task.remove()


onReady = ->
  $(document).on 'click', '.change-state', (e)->
    e.preventDefault()
    self = $(this)
    $.ajax
      type: 'post'
      dataType: 'json'
      url: self.attr("href")
      success: (task)->
        change_task_place self.closest('.panel'), task.aasm_state, task.id

$(document).ready(onReady)