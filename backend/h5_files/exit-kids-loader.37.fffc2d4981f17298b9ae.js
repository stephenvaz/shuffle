(window.webpackJsonp=window.webpackJsonp||[]).push([[37],{1920:function(e,n,t){var r=t(1921),o=t(75),i="string"==typeof r?[[e.i,r,""]]:r;(n=e.exports=r.locals||{})._getContent=function(){return i},n._getCss=function(){return""+r},n._updateCss=function(n){i="string"==typeof(r=n)?[[e.i,r,""]]:r},n._insertCss=function(e){return o(i,e)}},1921:function(e,n,t){(n=t(72)(!1)).push([e.i,".profile-exit{font-size:14px;float:right;border:solid 1px var(--TEXT_COLOR_L2);border-radius:5px;color:var(--TEXT_COLOR_L1);outline:none;background-color:transparent;margin:15px 0 7px 25px}\n",""]),e.exports=n},2046:function(e,n,t){"use strict";t.r(n);var r=t(4),o=t.n(r),i=t(9),s=t(94),a=t.n(s),c=(t(32),t(113)),u=t(112),f=t(50),l=t(2),p=t.n(l),d=t(0),b=t.n(d),v=t(42),m=t.n(v),x=t(53),_=t.n(x),C=t(1920),w=t.n(C);var N=m()(w.a)((function(e){var n=e.title,t=e.onClick,r=e.className;return o()("button",{type:"button",className:_()("profile-exit",r),onClick:t},void 0,n)})),T=t(23),g=t(18),P=t(34),h={kids:"web__home__EXIT_KIDS_CTA"};function k(e){var n=e.profileType,t=e.menuActions,r=e.className,s=e.globalActions,a=Object(g.e)(h[n]);return Object(i.useEffect)((function(){return P.a.switchProfileEvents.on("onPINRequiredError",p()(b.a.mark((function e(){return b.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,s.fetchProfileInfo();case 2:t.exitCurrentProfile();case 3:case"end":return e.stop()}}),e)})))),function(){P.a.switchProfileEvents.off("onPINRequiredError")}}),[]),!a||T.a.isDeviceType("mobile")?null:o()(N,{className:r,title:a,onClick:function(){t.exitCurrentProfile()}})}k.defaultProps={className:""};var E=k,y=t(22);function O(e){var n=e.className;return o()(a.a,{stores:{profileType:function(){return Object(f.b)(c.a,"profileType","")}},actions:{menuActions:u.a,globalActions:y.a}},void 0,o()(E,{className:n}))}O.defaultProps={className:""};n.default=O}}]);