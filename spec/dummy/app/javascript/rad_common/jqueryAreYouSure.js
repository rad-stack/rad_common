import $ from 'jquery';

(function($) {

  $.fn.areYouSure = function(options) {

    var settings = $.extend(
      {
        'message': 'You have unsaved changes!',
        'dirtyClass': 'dirty',
        'change': null,
        'silent': false,
        'addRemoveFieldsMarksDirty': false,
        'fieldEvents': 'change keyup propertychange input',
        'fieldSelector': ':input:not(input[type=submit]):not(input[type=button])'
      }, options);

    var getTrixValue = function($trixEditor) {
      if ($trixEditor.hasClass('ays-ignore') ||
        $trixEditor.hasClass('aysIgnore') ||
        $trixEditor.attr('data-ays-ignore')) {
        return null;
      }

      var editor = $trixEditor[0].editor;
      if (editor) {
        return editor.getDocument().toString();
      }
      return '';
    };

    var getValue = function($field) {
      if ($field.hasClass('ays-ignore') ||
        $field.hasClass('aysIgnore') ||
        $field.attr('data-ays-ignore') ||
        $field.attr('name') === undefined) {
        return null;
      }

      if ($field.is(':disabled')) {
        return 'ays-disabled';
      }

      var val;
      var type = $field.attr('type');
      if ($field.is('select')) {
        type = 'select';
      }

      switch (type) {
      case 'checkbox':
      case 'radio':
        val = $field.is(':checked');
        break;
      case 'select':
        val = '';
        $field.find('option').each(function(o) {
          var $option = $(this);
          if ($option.is(':selected')) {
            val += $option.val();
          }
        });
        break;
      default:
        val = $field.val();
      }

      return val;
    };

    var storeOrigValue = function($field) {
      $field.data('ays-orig', getValue($field));
    };

    var storeOrigTrixValue = function($trixEditor) {
      $trixEditor.data('ays-orig', getTrixValue($trixEditor));
    };

    var checkForm = function(evt) {

      var isFieldDirty = function($field) {
        var origValue = $field.data('ays-orig');
        if (undefined === origValue) {
          return false;
        }
        return (getValue($field) != origValue);
      };

      var isTrixEditorDirty = function($trixEditor) {
        var origValue = $trixEditor.data('ays-orig');
        if (undefined === origValue) {
          return false;
        }
        return (getTrixValue($trixEditor) != origValue);
      };

      var $form = ($(this).is('form'))
        ? $(this)
        : $(this).parents('form');

      // Test on the target first as it's the most likely to be dirty
      if ($(evt.target).is('trix-editor')) {
        if (isTrixEditorDirty($(evt.target))) {
          setDirtyStatus($form, true);
          return;
        }
      } else if (isFieldDirty($(evt.target))) {
        setDirtyStatus($form, true);
        return;
      }

      var $fields = $form.find(settings.fieldSelector);

      if (settings.addRemoveFieldsMarksDirty) {
        // Check if field count has changed
        var origCount = $form.data('ays-orig-field-count');
        if (origCount != $fields.length) {
          setDirtyStatus($form, true);
          return;
        }
      }

      // Brute force - check each field
      var isDirty = false;
      $fields.each(function() {
        var $field = $(this);
        if (isFieldDirty($field)) {
          isDirty = true;
          return false; // break
        }
      });

      // Also check Trix editors
      if (!isDirty) {
        var $trixEditors = $form.find('trix-editor');
        $trixEditors.each(function() {
          var $trixEditor = $(this);
          if (isTrixEditorDirty($trixEditor)) {
            isDirty = true;
            return false; // break
          }
        });
      }

      setDirtyStatus($form, isDirty);
    };

    var initForm = function($form) {
      var fields = $form.find(settings.fieldSelector);
      $(fields).each(function() { storeOrigValue($(this)); });
      $(fields).unbind(settings.fieldEvents, checkForm);
      $(fields).bind(settings.fieldEvents, checkForm);
      $form.data('ays-orig-field-count', $(fields).length);

      var $trixEditors = $form.find('trix-editor');
      $trixEditors.each(function() { storeOrigTrixValue($(this)); });
      $trixEditors.unbind('trix-change', checkForm);
      $trixEditors.bind('trix-change', checkForm);

      setDirtyStatus($form, false);
    };

    var setDirtyStatus = function($form, isDirty) {
      var changed = isDirty != $form.hasClass(settings.dirtyClass);
      $form.toggleClass(settings.dirtyClass, isDirty);

      // Fire change event if required
      if (changed) {
        if (settings.change) settings.change.call($form, $form);

        if (isDirty) $form.trigger('dirty.areYouSure', [$form]);
        if (!isDirty) $form.trigger('clean.areYouSure', [$form]);
        $form.trigger('change.areYouSure', [$form]);
      }
    };

    var rescan = function() {
      var $form = $(this);
      var fields = $form.find(settings.fieldSelector);
      $(fields).each(function() {
        var $field = $(this);
        if (!$field.data('ays-orig')) {
          storeOrigValue($field);
          $field.bind(settings.fieldEvents, checkForm);
        }
      });

      var $trixEditors = $form.find('trix-editor');
      $trixEditors.each(function() {
        var $trixEditor = $(this);
        if (!$trixEditor.data('ays-orig')) {
          storeOrigTrixValue($trixEditor);
          $trixEditor.bind('trix-change', checkForm);
        }
      });

      // Check for changes while we're here
      $form.trigger('checkform.areYouSure');
    };

    var reinitialize = function() {
      initForm($(this));
    };

    if (!settings.silent && !window.aysUnloadSet) {
      window.aysUnloadSet = true;
      $(window).bind('beforeunload', function() {
        var $dirtyForms = $('form').filter('.' + settings.dirtyClass);
        if ($dirtyForms.length == 0) {
          return;
        }
        // Prevent multiple prompts - seen on Chrome and IE
        if (navigator.userAgent.toLowerCase().match(/msie|chrome/)) {
          if (window.aysHasPrompted) {
            return;
          }
          window.aysHasPrompted = true;
          window.setTimeout(function() { window.aysHasPrompted = false; }, 900);
        }
        return settings.message;
      });
    }

    return this.each(function(elem) {
      if (!$(this).is('form')) {
        return;
      }
      var $form = $(this);

      $form.submit(function() {
        $form.removeClass(settings.dirtyClass);
      });
      $form.bind('reset', function() { setDirtyStatus($form, false); });
      // Add custom events
      $form.bind('rescan.areYouSure', rescan);
      $form.bind('reinitialize.areYouSure', reinitialize);
      $form.bind('checkform.areYouSure', checkForm);
      initForm($form);
    });
  };
})($);
