# Place all the behaviors and hooks related to the matching controllers here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.api.tasks =
  init: ->
    container = $('div#projects')

    liveElements =
      plusSignLabel: 'i.new-task-label'
      taskNameInput: 'input#task_name'
      taskForm: 'form.new-task'
      deleteTasks: 'a.delete-selected-tasks'
      editTask: 'a.edit-task-name'
      editStartDateTime: 'a.edit-start-time'
      editEndDateTime: 'a.edit-end-time'
      completeTask: 'a.complete-task'

    callbacks =
      editTask: (event) ->
        event.stopPropagation()
        event.preventDefault()
        taskId = @id.replace('edit-task-name-', '')
        $("span#task-#{taskId}").editable('toggle')

      editStartDateTime: (event) ->
        event.stopPropagation()
        event.preventDefault()
        taskId = @id.replace('edit-start-time-', '')
        $("span#edit-start-time-#{taskId}").editable({
          format: 'dd.mm.yyyy',
          viewformat: 'dd.mm.yyyy',
          clear: '',
          datepicker: {startDate: new Date}
        })
        $("span#edit-start-time-#{taskId}").editable('toggle')
      editEndDateTime: (event) ->
        event.stopPropagation()
        event.preventDefault()
        taskId = @id.replace('edit-end-time-', '')
        $("span#edit-end-time-#{taskId}").editable({
          format: 'dd.mm.yyyy',
          viewformat: 'dd.mm.yyyy',
          clear: '',
          datepicker: {startDate: new Date}
        })
        $("span#edit-end-time-#{taskId}").editable('toggle')

      completeTask: ->
        task = $(this).parents('li.task-item')

        task.parents('form').find('input[type="checkbox"]:checked').prop 'checked', false
        task.toggleClass('completed').find('a.complete-task i').toggleClass('icon-thumbs-up icon-thumbs-down')


    container.on 'keyup', liveElements.taskNameInput, $.api.utils.toggleSubmit

    container.on 'click', liveElements.plusSignLabel, ->
      $(this).parents('div.new-task-container').
      find('form').
      find('input#task_name').focus()

    # Create
    container.on 'ajax:complete', liveElements.taskForm, (event, xhr, status) ->
      response = $.parseJSON(xhr.responseText)

      if (status == 'success')
        $this = $(this).trigger('reset')
        $this.parents('div.project-body').find('div.project-tasks ul.todo-list').prepend(response.entry)
      else
        $.api.utils.assignErrorsFor('task', response.errors, $(this))

    container.on 'ajax:beforeSend', liveElements.taskForm, $.api.utils.resetForm

    # Destroy
    container.on 'click', liveElements.deleteTasks, (event) ->
      event.preventDefault()
      return false if $(this).parents('form').find('input[type="checkbox"]:checked').length == 0

      $(this).parents('form').submit() if confirm(I18n.t('common.are_you_sure?'))

    container.on 'ajax:complete', 'form.bulk-destroy-tasks', ->
      for input in $(this).find('input[type="checkbox"]:checked')
        $(input).parents('li').remove()

    # Edit
    container.on 'click', liveElements.editTask, callbacks.editTask
    container.on 'click', liveElements.editStartDateTime, callbacks.editStartDateTime
    container.on 'click', liveElements.editEndDateTime, callbacks.editEndDateTime

    # Priority
    $.api.utils.setAsSortable('ul.todo-list', 'draggable-task-placeholder', '.task-drag-handle')

    # Complete
    container.on 'ajax:beforeSend', liveElements.completeTask, callbacks.completeTask

