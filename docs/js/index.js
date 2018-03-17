var Setting,Board,AI;String.prototype.to_i=function(){return parseInt(this,10)},String.prototype.row_col=function(){var t,n,o,e,r;for(r=[],n=0,o=(e=this.split("")).length;n<o;n++)t=e[n],r.push(t.to_i());return r},Setting=function(){function t(){}return t.DISK={BLACK:"black",WHITE:"white",NONE:""},t.AI={SCORE:{A:0,B:0,C:-5,X:-10,CORNER:30,NONE:0}},t.BOARD={INITIAL:[["","","","","","","",""],["","","","","","","",""],["","","","","","","",""],["","","",t.DISK.WHITE,t.DISK.BLACK,"","",""],["","","",t.DISK.BLACK,t.DISK.WHITE,"","",""],["","","","","","","",""],["","","","","","","",""],["","","","","","","",""]],SCORE:[[t.AI.SCORE.CORNER,t.AI.SCORE.C,t.AI.SCORE.A,t.AI.SCORE.B,t.AI.SCORE.B,t.AI.SCORE.A,t.AI.SCORE.C,t.AI.SCORE.CORNER],[t.AI.SCORE.C,t.AI.SCORE.X,0,0,0,0,t.AI.SCORE.X,t.AI.SCORE.C],[t.AI.SCORE.A,0,0,0,0,0,0,t.AI.SCORE.A],[t.AI.SCORE.B,0,0,0,0,0,0,t.AI.SCORE.B],[t.AI.SCORE.B,0,0,0,0,0,0,t.AI.SCORE.B],[t.AI.SCORE.A,0,0,0,0,0,0,t.AI.SCORE.A],[t.AI.SCORE.C,t.AI.SCORE.X,0,0,0,0,t.AI.SCORE.X,t.AI.SCORE.C],[t.AI.SCORE.CORNER,t.AI.SCORE.C,t.AI.SCORE.A,t.AI.SCORE.B,t.AI.SCORE.B,t.AI.SCORE.A,t.AI.SCORE.C,t.AI.SCORE.CORNER]]},t}(),Board=function(){function t(){this.cells=Setting.BOARD.INITIAL,this.this_player=Setting.DISK.BLACK,this.next_player=Setting.DISK.WHITE,this.blank_cells=60,this.AI="-",this.you="-"}return t.ADJACENT=[[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]],t.prototype.clone=function(){return jQuery.extend(!0,{},this)},t.prototype.change=function(){var t;return t=[this.next_player,this.this_player],this.this_player=t[0],this.next_player=t[1],t},t.prototype.count_you=function(){var t,n,o,e,r,i,a,s,_;for(n=0,_=o=0,r=(a=this.cells).length;o<r;_=++o)for(t=e=0,i=(s=a[_]).length;e<i;t=++e)s[t]===this.you&&(n+=1);return n},t.prototype.count_AI=function(){var t,n,o,e,r,i,a,s,_;for(n=0,_=o=0,r=(a=this.cells).length;o<r;_=++o)for(t=e=0,i=(s=a[_]).length;e<i;t=++e)s[t]===this.AI&&(n+=1);return n},t.prototype.draw=function(){return this.draw_board(),$(".mini_disk.you").text(this.count_you()),$(".mini_disk.AI").text(this.count_AI())},t.prototype.draw_board=function(){var t,n,o,e,r,i,a,s,_;for(i=this.cells,a=[],_=e=0,r=i.length;e<r;_=++e)s=i[_],a.push(function(){var e,r,i;for(i=[],o=e=0,r=s.length;e<r;o=++e)n=s[o],t=$("#"+_+o),this.can_move(_,o)?t.addClass("movable"):t.removeClass("movable"),n!==Setting.DISK.NONE?(t.addClass("disk"),t.removeClass(Setting.DISK.BLACK),t.removeClass(Setting.DISK.WHITE),i.push(t.addClass(n))):i.push(void 0);return i}.call(this));return a},t.prototype.draw_result=function(){return $(".mini_disk.AI").text().to_i()<$(".mini_disk.you").text().to_i()?$(".your_result").text("YOU WIN!!!"):$(".mini_disk.you").text().to_i()<$(".mini_disk.AI").text().to_i()?$(".your_result").text("YOU LOSE..."):$(".your_result").text("DRAW"),$(".modal").fadeIn(),$(".result").fadeIn()},t.prototype.movable_cells=function(){var t,n,o,e,r,i,a,s,_;for(i=[],_=n=0,e=(a=this.cells).length;n<e;_=++n)for(t=o=0,r=(s=a[_]).length;o<r;t=++o)s[t],this.can_move(_,t)&&i.push([_,t]);return i},t.prototype.movable_cells_length=function(){return this.movable_cells().length},t.prototype.can_move_anywhere=function(){var t,n,o,e,r,i,a,s;for(s=n=0,e=(i=this.cells).length;n<e;s=++n)for(t=o=0,r=(a=i[s]).length;o<r;t=++o)if(a[t],this.can_move(s,t))return!0;return!1},t.prototype.move=function(t,n){return this.blank_cells-=1,this.flip(t,n),this.change()},t.prototype.can_move=function(n,o){var e,r,i,a,s,_;if(this.cells[n][o]!==Setting.DISK.NONE)return!1;for(e=0,r=(i=t.ADJACENT).length;e<r;e++)if(_=(a=i[e])[0],s=a[1],0<this.flip_disk_each_direction(n,o,_,s).length)return!0;return!1},t.prototype.flip=function(n,o){var e,r,i,a,s,_,l,u,c;for(this.cells[n][o]=this.this_player,l=[],i=0,a=(s=t.ADJACENT).length;i<a;i++)_=s[i],c=_[0],u=_[1],l.push(function(){var t,i,a,s,_;for(_=[],t=0,i=(a=this.flip_disk_each_direction(n,o,c,u)).length;t<i;t++)s=a[t],r=s[0],e=s[1],_.push(this.cells[r][e]=this.this_player);return _}.call(this));return l},t.prototype.flip_disk=function(n,o){var e,r,i,a,s,_,l;for(e=[],r=0,i=(a=t.ADJACENT).length;r<i;r++)l=(s=a[r])[0],_=s[1],e=e.concat(this.flip_disk_each_direction(n,o,l,_));return e},t.prototype.flip_disk_each_direction=function(t,n,o,e){var r,i,a,s,_;for(s=[],a=t,i=n,_=0;_<=8;_++){if(i+=e,!(0<=(a+=o)&&a<=7&&0<=i&&i<=7))return[];if((r=this.cells[a][i])!==this.next_player)return r===this.this_player?s:[];s.push([a,i])}},t}(),AI=function(){function t(t){this.board=t}return t.prototype.search=function(){},t}();var AI1,extend=function(t,n){for(var o in n)hasProp.call(n,o)&&(t[o]=n[o]);function e(){this.constructor=t}return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},hasProp={}.hasOwnProperty;AI1=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return extend(n,AI),n.prototype.search=function(){var t,n,o,e,r,i,a,s,_,l,u;for(n in _=(e=[-1,-1])[0],s=e[1],o=-64,r=this.board.movable_cells())l=(i=r[n])[0],t=i[1],o<(u=this.board.flip_disk(l,t).length)&&(o=u,_=(a=[l,t])[0],s=a[1]);return[_,s]},n}();var AI2;extend=function(t,n){for(var o in n)hasProp.call(n,o)&&(t[o]=n[o]);function e(){this.constructor=t}return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},hasProp={}.hasOwnProperty;AI2=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return extend(n,AI),n.prototype.search=function(){var t,n,o,e,r,i,a,s,_,l,u;for(n in _=(e=[-1,-1])[0],s=e[1],o=64,r=this.board.movable_cells())l=(i=r[n])[0],t=i[1],(u=this.board.flip_disk(l,t).length)<o&&(o=u,_=(a=[l,t])[0],s=a[1]);return[_,s]},n}();var AI3;extend=function(t,n){for(var o in n)hasProp.call(n,o)&&(t[o]=n[o]);function e(){this.constructor=t}return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},hasProp={}.hasOwnProperty;AI3=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return extend(n,AI),n.prototype.search=function(){var t,n,o,e,r,i,a,s,_,l,u,c;for(n in l=(r=[-1,-1])[0],_=r[1],o=-64,i=this.board.movable_cells())u=(a=i[n])[0],t=a[1],(e=this.board.clone()).move(u,t),o<(c=this.more_move_count(e))&&(o=c,l=(s=[u,t])[0],_=s[1]);return[l,_]},n.prototype.more_move_count=function(t){var n;return n=t.movable_cells_length(),t.change(),t.movable_cells_length()-n},n}();var AI4;extend=function(t,n){for(var o in n)hasProp.call(n,o)&&(t[o]=n[o]);function e(){this.constructor=t}return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},hasProp={}.hasOwnProperty;AI4=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return extend(n,AI3),n.prototype.search=function(){var t,n,o,e,r,i,a,s,_,l,u,c;for(n in l=(r=[-1,-1])[0],_=r[1],o=-64,i=this.board.movable_cells())u=(a=i[n])[0],t=a[1],(e=this.board.clone()).move(u,t),o<(c=this.min_score(e))&&(o=c,l=(s=[u,t])[0],_=s[1]);return[l,_]},n.prototype.min_score=function(t){var n,o,e,r,i,a,s,_;for(o in s=64,r=t.movable_cells())a=(i=r[o])[0],n=i[1],(e=t.clone()).move(a,n),(_=this.more_move_count(e))<s&&(s=_);return s},n}();var AI5;extend=function(t,n){for(var o in n)hasProp.call(n,o)&&(t[o]=n[o]);function e(){this.constructor=t}return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},hasProp={}.hasOwnProperty;AI5=function(t){function n(t){this.board=t,this.not_final_depth_limit=1}return extend(n,AI),n.prototype.search=function(){return this.search_not_final()},n.prototype.search_not_final=function(){var t,n,o,e,r,i,a,s,_,l,u,c;for(n in o=(r=[-64,-1,-1])[0],l=r[1],_=r[2],i=this.board.movable_cells())u=(a=i[n])[0],t=a[1],(e=this.board.clone()).move(u,t),c=this.search_not_final_best_of_you(e,0,o),o<(c+=Setting.BOARD.SCORE[u][t])&&(o=(s=[c,u,t])[0],l=s[1],_=s[2]);return[l,_]},n.prototype.search_not_final_best_of_AI=function(t,n,o){var e,r,i,a,s,_,l,u;if(this.not_final_depth_limit<=n)return this.evaluate_not_final(t);if(i=-64,0===(a=t.movable_cells()).length)return t.change(),t.can_move_anywhere()?this.search_not_final_best_of_you(t,n+1,i):this.evaluate_not_final(t);for(r in a){if(l=(_=a[r])[0],e=_[1],(s=t.clone()).move(l,e),u=this.search_not_final_best_of_you(s,n+1,i),o<(u+=Setting.BOARD.SCORE[l][e]))return u;i<u&&(i=u)}return i},n.prototype.search_not_final_best_of_you=function(t,n,o){var e,r,i,a,s,_,l,u;if(this.not_final_depth_limit<=n)return t.change(),this.evaluate_not_final(t);if(i=64,0===(a=t.movable_cells()).length)return t.change(),t.can_move_anywhere()?this.search_not_final_best_of_AI(t,n+1,i):64;for(r in a){if(l=(_=a[r])[0],e=_[1],(s=t.clone()).move(l,e),u=this.search_not_final_best_of_AI(s,n+1,i),(u-=Setting.BOARD.SCORE[l][e])<o)return u;u<i&&(i=u)}return i},n.prototype.evaluate_not_final=function(t){var n;return n=t.movable_cells_length(),t.change(),n-t.movable_cells_length()},n}();var AI6;extend=function(t,n){for(var o in n)hasProp.call(n,o)&&(t[o]=n[o]);function e(){this.constructor=t}return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},hasProp={}.hasOwnProperty;AI6=function(t){function n(t){this.board=t,this.not_final_depth_limit=1,this.final_depth_limit=1}return extend(n,AI5),n.prototype.search=function(){return 16<this.board.blank_cells?this.search_not_final():this.search_final()},n.prototype.search_final=function(){var t,n,o,e,r,i,a,s,_,l,u,c;for(n in o=(r=[-64,-1,-1])[0],l=r[1],_=r[2],i=this.board.movable_cells())u=(a=i[n])[0],t=a[1],(e=this.board.clone()).move(u,t),o<(c=this.search_final_best_of_you(e,0,o))&&(o=(s=[c,u,t])[0],l=s[1],_=s[2]);return[l,_]},n.prototype.search_final_best_of_AI=function(t,n,o){var e,r,i,a,s,_,l,u;if(this.final_depth_limit<=n)return this.evaluate_final(t);if(i=-64,0===(a=t.movable_cells()).length)return t.change(),t.can_move_anywhere()?this.search_final_best_of_you(t,n+1,i):this.evaluate_final(t);for(r in a){if(l=(_=a[r])[0],e=_[1],(s=t.clone()).move(l,e),(u=this.search_final_best_of_you(s,n+1,i))<o)return u;i<u&&(i=u)}return i},n.prototype.search_final_best_of_you=function(t,n,o){var e,r,i,a,s,_,l,u;if(this.final_depth_limit<=n)return this.evaluate_final(t);if(i=64,0===(a=t.movable_cells()).length)return t.change(),t.can_move_anywhere()?this.search_final_best_of_AI(t,n+1,i):this.evaluate_final(t);for(r in a){if(l=(_=a[r])[0],e=_[1],(s=t.clone()).move(l,e),o<(u=this.search_final_best_of_AI(s,n+1,i)))return u;u<i&&(i=u)}return i},n.prototype.evaluate_final=function(t){var n,o,e,r,i,a,s,_,l,u;for(e=0,u=r=0,a=(_=t.cells).length;r<a;u=++r)for(o=i=0,s=(l=_[u]).length;i<s;o=++i)(n=l[o])===t.AI?e+=1:n===t.you&&(e-=1);return e},n}();var AI7;extend=function(t,n){for(var o in n)hasProp.call(n,o)&&(t[o]=n[o]);function e(){this.constructor=t}return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},hasProp={}.hasOwnProperty;AI7=function(t){function n(t){this.board=t,this.not_final_depth_limit=3,this.final_depth_limit=7}return extend(n,AI6),n}();var AI8;extend=function(t,n){for(var o in n)hasProp.call(n,o)&&(t[o]=n[o]);function e(){this.constructor=t}return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},hasProp={}.hasOwnProperty;AI8=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return extend(n,AI7),n.prototype.evaluate_not_final=function(t){var n;return n=t.movable_cells_length(),t.change(),n-2*t.movable_cells_length()-t.count_AI()/2},n}(),window.onload=function(){var t,n;return window.board=new Board,window.board.draw(),$(".big_disk.black").on("click",function(){return window.board.you=Setting.DISK.BLACK,window.board.AI=Setting.DISK.WHITE,$(".mini_disk.you").addClass("black"),$(".mini_disk.AI").addClass("white"),$(".choose_disk").hide(),$(".modal").fadeOut(),window.board.draw()}),$(".big_disk.white").on("click",function(){return window.board.you=Setting.DISK.WHITE,window.board.AI=Setting.DISK.BLACK,$(".mini_disk.you").addClass("white"),$(".mini_disk.AI").addClass("black"),$(".choose_disk").hide(),$(".modal").fadeOut(),t(),window.board.draw()}),$(".cell").on("click",function(){var t,o,e;if(e=(o=$(this).attr("id").row_col())[0],t=o[1],window.board.can_move(e,t))return n(e,t).then(function(){if($(".loading").hide(),window.board.draw(),!window.board.can_move_anywhere())return window.board.draw_result()})}),n=function(n,o){return new Promise(function(e){return $(".loading").show(),window.board.move(n,o),window.board.draw(),setTimeout(function(){return window.board.can_move_anywhere()?t():window.board.change(),e()},10)})},t=function(){var n,o,e;if(e=(o=new AI8(window.board).search())[0],n=o[1],window.board.move(e,n),!window.board.can_move_anywhere()&&(window.board.change(),window.board.can_move_anywhere()))return t()},$(".result").on("click",".retry",function(){return location.reload()})};