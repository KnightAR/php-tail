<script type="text/javascript">
{literal}
    /* <![CDATA[ */
    //Last know size of the file
    lastSize = 0;
    //Grep keyword
    grep = "";
    //Should the Grep be inverted?
    invert = 0;
    //Last known document height
    documentHeight = 0;
    //Last known scroll position
    scrollPosition = 0;
    //Should we scroll to the bottom?
    scroll = true;
    
    lastFile = window.location.hash != "" ? window.location.hash.substr(1) : "";
    
    var hash = lastFile;
    var split = hash.split(":");
    if (split.length > 1) {
        lastFile = split[0];
    }
    console.log(lastFile);
    $(document).ready(function() {
        // Setup the settings dialog
        $("#settings").dialog({
            modal : true,
            resizable : false,
            draggable : false,
            autoOpen : false,
            width : 590,
            height : 270,
            buttons : {
                Close : function() {
                    $(this).dialog("close");
                }
            },
            open : function(event, ui) {
                scrollToBottom();
            },
            close : function(event, ui) {
                grep = $("#grep").val();
                invert = $('#invert input:radio:checked').val();
                $("#results").text("");
                lastSize = 0;
                $("#grepspan").html("Grep keyword: \"" + grep + "\"");
                $("#invertspan").html("Inverted: " + (invert == 1 ? 'true' : 'false'));
            }
        });
        //Close the settings dialog after a user hits enter in the textarea
        $('#grep').keyup(function(e) {
            if (e.keyCode == 13) {
                $("#settings").dialog('close');
            }
        });
        //Focus on the textarea
        $("#grep").focus();
        //Settings button into a nice looking button with a theme
        //Settings button opens the settings dialog
        $("#grepKeyword").click(function() {
            $("#settings").dialog('open');
            $("#grepKeyword").removeClass('ui-state-focus');
        });
        $(".file").click(function(e) {
            $("#results").text("");
            lastSize = 0;
console.log(e);
            lastFile = $(e.target).text();
        });

        //Set up an interval for updating the log. Change updateTime in the PHPTail contstructor to change this
        setInterval("updateLog()", {/literal}{$this->updateTime()}{literal});
        //Some window scroll event to keep the menu at the top
        $(window).scroll(function(e) {
            if ($(window).scrollTop() > 0) {
                $('.float').css({
                    position : 'fixed',
                    top : '0',
                    left : 'auto'
                });
            } else {
                $('.float').css({
                    position : 'static'
                });
            }
        });
        //If window is resized should we scroll to the bottom?
        $(window).resize(function() {
            if (scroll) {
                scrollToBottom();
            }
        });
        //Handle if the window should be scrolled down or not
        $(window).scroll(function() {
            documentHeight = $(document).height();
            scrollPosition = $(window).height() + $(window).scrollTop();
            if (documentHeight <= scrollPosition) {
                scroll = true;
            } else {
                scroll = false;
            }
        });
        $('#results').on('click', '.jumpto', function(e) {
            $('.highlight').removeClass('highlight');
            e.preventDefault();
            var target = $(e.target);
            var parent = target.parent();
            var el = $("span[name='"+ parent.attr('name') +"']");
            $("html, body").animate({scrollTop: el.offset().top - 55}, "fast");
            window.location.hash = '#' + parent.attr('name');
            el.addClass('highlight');
        });
        scrollToBottom();

    });
    //This function scrolls to the bottom
    function scrollToBottom() {
        $("html, body").animate({scrollTop: $(document).height()}, "fast");
    }
    //This function queries the server for updates.
    function updateLog() {
        $.getJSON('?ajax=1&file=' + lastFile + '&lastsize=' + lastSize + '&grep=' + grep + '&invert=' + invert, function(data) {
            lastSize = data.size;
            lastFile = data.filename;
            $("#current").text(data.file);
            $.each(data.data, function(key, value) {
                $("#results").append('<span name="'+ lastFile + ':' + key + '"><a href="#'+ lastFile + ':' + key + '" class="jumpto">' + key + ' : </a>' + value + '</span><br/>');
            });
            if (scroll) {
                if (split.length > 1) {
                    var el = $("span[name='"+ hash +"']");
                    $("html, body").animate({scrollTop: el.offset().top - 55}, "fast");
                    el.addClass('highlight');
                    split = [];
                } else {
                    scrollToBottom();
                }
            }
        });
    }
    /* ]]> */
{/literal}
</script>