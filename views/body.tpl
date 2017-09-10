<div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">PHP Tail</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Files<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        {foreach from=$this->getLogs() key=title item=f}
                        <li><a class="file" href="#{$title}">{$title}</a></li>
                        {/foreach}
                    </ul>
                </li>
                <li><a href="#" id="grepKeyword">Settings</a></li>
                <li><span class="navbar-text" id="grepspan"></span></li>
                <li><span class="navbar-text" id="invertspan"></span></li>
            </ul>
            <p class="navbar-text navbar-right" id="current"></p>
        </div>
    </div>
</div>
<div class="contents">
    <div id="results" class="results"></div>
    <div id="settings" title="PHPTail settings">
        <p>Grep keyword (return results that contain this keyword)</p>
        <input id="grep" type="text" value="" />
        <p>Should the grep keyword be inverted? (Return results that do NOT contain the keyword)</p>
        <div id="invert">
            <input type="radio" value="1" id="invert1" name="invert" /><label for="invert1">Yes</label>
            <input type="radio" value="0" id="invert2" name="invert" checked="checked" /><label for="invert2">No</label>
        </div>
    </div>
</div>