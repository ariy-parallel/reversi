var Setting,Turn,Board,AI;String.prototype.to_i=function(){return parseInt(this,10)},String.prototype.row_col=function(){var t,o,r,e,n;for(n=[],o=0,r=(e=this.split("")).length;o<r;o++)t=e[o],n.push(t.to_i());return n},Setting=function(){function t(){}return t.DISK={BLACK:"black",WHITE:"white",NONE:""},t.AI={SCORE:{A:0,B:0,C:-5,X:-10,CORNER:20,NONE:0}},t.BOARD={INITIAL:[["","","","","","","",""],["","","","","","","",""],["","","","","","","",""],["","","",t.DISK.WHITE,t.DISK.BLACK,"","",""],["","","",t.DISK.BLACK,t.DISK.WHITE,"","",""],["","","","","","","",""],["","","","","","","",""],["","","","","","","",""]],ADDRESS:{"00":t.AI.SCORE.CORNER,"01":t.AI.SCORE.C,"02":t.AI.SCORE.A,"03":t.AI.SCORE.B,"04":t.AI.SCORE.B,"05":t.AI.SCORE.A,"06":t.AI.SCORE.C,"07":t.AI.SCORE.CORNER,10:t.AI.SCORE.C,11:t.AI.SCORE.X,12:t.AI.SCORE.NONE,13:t.AI.SCORE.NONE,14:t.AI.SCORE.NONE,15:t.AI.SCORE.NONE,16:t.AI.SCORE.X,17:t.AI.SCORE.C,20:t.AI.SCORE.A,21:t.AI.SCORE.NONE,22:t.AI.SCORE.NONE,23:t.AI.SCORE.NONE,24:t.AI.SCORE.NONE,25:t.AI.SCORE.NONE,26:t.AI.SCORE.NONE,27:t.AI.SCORE.A,30:t.AI.SCORE.B,31:t.AI.SCORE.NONE,32:t.AI.SCORE.NONE,33:t.AI.SCORE.NONE,34:t.AI.SCORE.NONE,35:t.AI.SCORE.NONE,36:t.AI.SCORE.NONE,37:t.AI.SCORE.B,40:t.AI.SCORE.B,41:t.AI.SCORE.NONE,42:t.AI.SCORE.NONE,43:t.AI.SCORE.NONE,44:t.AI.SCORE.NONE,45:t.AI.SCORE.NONE,46:t.AI.SCORE.NONE,47:t.AI.SCORE.B,50:t.AI.SCORE.A,51:t.AI.SCORE.NONE,52:t.AI.SCORE.NONE,53:t.AI.SCORE.NONE,54:t.AI.SCORE.NONE,55:t.AI.SCORE.NONE,56:t.AI.SCORE.NONE,57:t.AI.SCORE.A,60:t.AI.SCORE.C,61:t.AI.SCORE.X,62:t.AI.SCORE.NONE,63:t.AI.SCORE.NONE,64:t.AI.SCORE.NONE,65:t.AI.SCORE.NONE,66:t.AI.SCORE.X,67:t.AI.SCORE.C,70:t.AI.SCORE.CORNER,71:t.AI.SCORE.C,72:t.AI.SCORE.A,73:t.AI.SCORE.B,74:t.AI.SCORE.B,75:t.AI.SCORE.A,76:t.AI.SCORE.C,77:t.AI.SCORE.CORNER}},t}(),Turn=function(){function t(){this.this_player=Setting.DISK.BLACK,this.next_player=Setting.DISK.WHITE}return t.prototype.change=function(){var t;return t=[this.next_player,this.this_player],this.this_player=t[0],this.next_player=t[1],t},t}(),Board=function(){function t(){this.cells=Setting.BOARD.INITIAL,this.this_player=Setting.DISK.BLACK,this.next_player=Setting.DISK.WHITE,this.blank_cells=60,this.AI="-",this.you="-"}return t.ADJACENT=[[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]],t.prototype.clone=function(){return jQuery.extend(!0,{},this)},t.prototype.change=function(){var t;return t=[this.next_player,this.this_player],this.this_player=t[0],this.next_player=t[1],t},t.prototype.count_you=function(){var t,o,r,e,n,i,s,a,c;for(o=0,c=r=0,n=(s=this.cells).length;r<n;c=++r)for(t=e=0,i=(a=s[c]).length;e<i;t=++e)a[t]===this.you&&(o+=1);return o},t.prototype.count_AI=function(){var t,o,r,e,n,i,s,a,c;for(o=0,c=r=0,n=(s=this.cells).length;r<n;c=++r)for(t=e=0,i=(a=s[c]).length;e<i;t=++e)a[t]===this.AI&&(o+=1);return o},t.prototype.draw=function(){var t,o,r,e,n,i,s,a,c,l;for(l=e=0,i=(a=this.cells).length;e<i;l=++e)for(r=n=0,s=(c=a[l]).length;n<s;r=++n)o=c[r],t=$("#"+l+r),this.can_move(l,r)?t.addClass("movable"):t.removeClass("movable"),o!==Setting.DISK.NONE&&(t.addClass("disk"),t.removeClass(Setting.DISK.BLACK),t.removeClass(Setting.DISK.WHITE),t.addClass(o));return $(".mini_disk.you").text(this.count_you()),$(".mini_disk.AI").text(this.count_AI())},t.prototype.draw_result=function(){return $(".mini_disk.AI").text()<$(".mini_disk.you").text()?($(".result").text("YOU WIN!!!"),$(".result").addClass("win")):$(".mini_disk.you").text()<$(".mini_disk.AI").text()?($(".result").text("YOU LOSE..."),$(".result").addClass("lose")):$(".result").text("DRAW")},t.prototype.movable_cells=function(){var t,o,r,e,n,i,s,a,c;for(i={},c=o=0,e=(s=this.cells).length;o<e;c=++o)for(t=r=0,n=(a=s[c]).length;r<n;t=++r)a[t],this.can_move(c,t)&&(i[""+c+t]="");return i},t.prototype.movable_cells_length=function(){return Object.keys(this.movable_cells()).length},t.prototype.can_move_anywhere=function(){return 0<this.movable_cells_length()},t.prototype.move=function(t,o){return this.blank_cells-=1,this.flip(t,o),this.change()},t.prototype.can_move=function(o,r){var e,n,i,s,a,c;if(this.cells[o][r]!==Setting.DISK.NONE)return!1;for(e=0,n=(i=t.ADJACENT).length;e<n;e++)if(c=(s=i[e])[0],a=s[1],0<this.flip_disk_each_direction(o,r,c,a).length)return!0;return!1},t.prototype.flip=function(t,o){var r,e,n,i,s,a,c;for(this.cells[t][o]=this.this_player,s=[],r=0,e=(n=this.flip_disk(t,o)).length;r<e;r++)c=(i=n[r])[0],a=i[1],s.push(this.cells[c][a]=this.this_player);return s},t.prototype.flip_disk=function(o,r){var e,n,i,s,a,c,l;for(e=[],n=0,i=(s=t.ADJACENT).length;n<i;n++)l=(a=s[n])[0],c=a[1],e=e.concat(this.flip_disk_each_direction(o,r,l,c));return e},t.prototype.flip_disk_each_direction=function(t,o,r,e){var n,i,s,a,c;for(a=[],s=t,i=o,c=0;c<=8;c++){if(i+=e,!(0<=(s+=r)&&s<=7&&0<=i&&i<=7))return[];if((n=this.cells[s][i])!==this.next_player)return n===this.this_player?a:[];a.push([s,i])}},t}(),AI=function(){function t(t){this.board=t}return t.prototype.search=function(){},t}();var AI1,extend=function(t,o){for(var r in o)hasProp.call(o,r)&&(t[r]=o[r]);function e(){this.constructor=t}return e.prototype=o.prototype,t.prototype=new e,t.__super__=o.prototype,t},hasProp={}.hasOwnProperty;AI1=function(t){function o(){return o.__super__.constructor.apply(this,arguments)}return extend(o,AI),o.prototype.search=function(){var t,o,r,e,n,i,s,a,c,l;for(o in a=(e=[-1,-1])[0],s=e[1],r=-64,this.board.movable_cells())c=(n=o.row_col())[0],t=n[1],r<(l=this.board.flip_disk(c,t).length)&&(r=l,a=(i=[c,t])[0],s=i[1]);return[a,s]},o}();var AI2;extend=function(t,o){for(var r in o)hasProp.call(o,r)&&(t[r]=o[r]);function e(){this.constructor=t}return e.prototype=o.prototype,t.prototype=new e,t.__super__=o.prototype,t},hasProp={}.hasOwnProperty;AI2=function(t){function o(){return o.__super__.constructor.apply(this,arguments)}return extend(o,AI),o.prototype.search=function(){var t,o,r,e,n,i,s,a,c,l;for(o in a=(e=[-1,-1])[0],s=e[1],r=64,this.board.movable_cells())c=(n=o.row_col())[0],t=n[1],(l=this.board.flip_disk(c,t).length)<r&&(r=l,a=(i=[c,t])[0],s=i[1]);return[a,s]},o}();var AI3;extend=function(t,o){for(var r in o)hasProp.call(o,r)&&(t[r]=o[r]);function e(){this.constructor=t}return e.prototype=o.prototype,t.prototype=new e,t.__super__=o.prototype,t},hasProp={}.hasOwnProperty;AI3=function(t){function o(){return o.__super__.constructor.apply(this,arguments)}return extend(o,AI),o.prototype.search=function(){var t,o,r,e,n,i,s,a,c,l,_;for(o in c=(n=[-1,-1])[0],a=n[1],r=-64,this.board.movable_cells())l=(i=o.row_col())[0],t=i[1],(e=this.board.clone()).flip(l,t),r<(_=this.more_move_count(e))&&(r=_,c=(s=[l,t])[0],a=s[1]);return[c,a]},o.prototype.more_move_count=function(t){var o;return o=t.movable_cells_length(),t.change(),o-t.movable_cells_length()},o}();var AI4;extend=function(t,o){for(var r in o)hasProp.call(o,r)&&(t[r]=o[r]);function e(){this.constructor=t}return e.prototype=o.prototype,t.prototype=new e,t.__super__=o.prototype,t},hasProp={}.hasOwnProperty;AI4=function(t){function o(){return o.__super__.constructor.apply(this,arguments)}return extend(o,AI3),o.prototype.search=function(){var t,o,r,e,n,i,s,a,c,l,_;for(o in c=(n=[-1,-1])[0],a=n[1],r=-64,this.board.movable_cells())l=(i=o.row_col())[0],t=i[1],(e=this.board.clone()).move(l,t),r<(_=this.min_score(e))&&(r=_,c=(s=[l,t])[0],a=s[1]);return[c,a]},o.prototype.min_score=function(t){var o,r,e,n,i,s,a;for(r in s=64,t.movable_cells())i=(n=r.row_col())[0],o=n[1],(e=t.clone()).move(i,o),(a=this.more_move_count(e))<s&&(s=a);return s},o}();var AI5;extend=function(t,o){for(var r in o)hasProp.call(o,r)&&(t[r]=o[r]);function e(){this.constructor=t}return e.prototype=o.prototype,t.prototype=new e,t.__super__=o.prototype,t},hasProp={}.hasOwnProperty;AI5=function(t){function o(){return o.__super__.constructor.apply(this,arguments)}return extend(o,AI4),o.prototype.min_score=function(t,r){return o.__super__.min_score.call(this,t)+Setting.BOARD.ADDRESS[r]},o.prototype.search=function(){return this.search_not_final()},o.prototype.search_not_final=function(){var t,o,r,e,n,i,s,a,c,l,_;for(o in c=(n=[-1,-1])[0],a=n[1],r=-64,this.board.movable_cells())l=(i=o.row_col())[0],t=i[1],(e=this.board.clone()).move(l,t),r<(_=this.min_score(e,o))&&(r=_,c=(s=[l,t])[0],a=s[1]);return[c,a]},o}();var AI6;extend=function(t,o){for(var r in o)hasProp.call(o,r)&&(t[r]=o[r]);function e(){this.constructor=t}return e.prototype=o.prototype,t.prototype=new e,t.__super__=o.prototype,t},hasProp={}.hasOwnProperty;AI6=function(t){function o(){return o.__super__.constructor.apply(this,arguments)}return extend(o,AI5),o.prototype.search=function(){return 8<this.board.blank_cells?this.search_not_final():this.search_final()},o.prototype.search_final=function(){var t,o,r,e,n,i,s,a,c,l,_;for(o in c=(n=[-1,-1])[0],a=n[1],r=-64,this.board.movable_cells())l=(i=o.row_col())[0],t=i[1],(e=this.board.clone()).move(l,t),r<(_=this.search_best_of_you(e))&&(r=_,c=(s=[l,t])[0],a=s[1]);return[c,a]},o.prototype.search_best_of_AI=function(t){var o,r,e,n,i,s,a,c;if(n=t.movable_cells(),0===Object.keys(n).length)return t.change(),t.can_move_anywhere()?this.search_best_of_you(t):this.count_diff_with_you();for(r in e=-64,n)a=(s=r.row_col())[0],o=s[1],(i=t.clone()).move(a,o),e<(c=this.search_best_of_you(i))&&(e=c);return e},o.prototype.search_best_of_you=function(t){var o,r,e,n,i,s,a,c;if(n=t.movable_cells(),0===Object.keys(n).length)return t.change(),t.can_move_anywhere()?this.search_best_of_AI(t):this.count_diff_with_you();for(r in e=64,n)a=(s=r.row_col())[0],o=s[1],(i=t.clone()).move(a,o),(c=this.search_best_of_AI(i))<e&&(e=c);return e},o.prototype.count_diff_with_you=function(){var t,o,r,e,n,i,s,a,c,l;for(r=0,l=e=0,i=(a=this.board.cells).length;e<i;l=++e)for(o=n=0,s=(c=a[l]).length;n<s;o=++n)(t=c[o])===this.board.AI?r+=1:t===this.board.you&&(r-=1);return r},o}(),window.onload=function(){var t;return window.board=new Board,window.board.draw(),$(".big_disk.black").on("click",function(){return window.board.you=Setting.DISK.BLACK,window.board.AI=Setting.DISK.WHITE,$(".mini_disk.you").addClass("black"),$(".mini_disk.AI").addClass("white"),$(".modal").hide(),window.board.draw()}),$(".big_disk.white").on("click",function(){return window.board.you=Setting.DISK.WHITE,window.board.AI=Setting.DISK.BLACK,$(".mini_disk.you").addClass("white"),$(".mini_disk.AI").addClass("black"),$(".modal").hide(),t(),window.board.draw()}),$(".cell").on("click",function(){var o,r,e;if(e=(r=$(this).attr("id").row_col())[0],o=r[1],window.board.can_move(e,o))return window.board.move(e,o),window.board.can_move_anywhere()?t():window.board.change(),window.board.draw(),window.board.can_move_anywhere()?void 0:window.board.draw_result()}),t=function(){var o,r,e;if(e=(r=new AI6(window.board).search())[0],o=r[1],window.board.move(e,o),!window.board.can_move_anywhere()&&(window.board.change(),window.board.can_move_anywhere()))return t()}};