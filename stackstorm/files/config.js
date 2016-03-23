'use strict';
angular.module('main')
  .constant('st2Config', {
  // Use defaults for reference single-box deployment.
  // Use examples below for advanced setup.
   hosts: [{
  //    // With nginx as reverse proxy
      name: 'StackStorm',
      url: 'http://:80/api',
      auth: 'http://:80/auth'
//    }, 
  //    // Dev env settings with auth off
  //    name: 'Dev Env',
  //    url: '//172.168.90.50:9101',
  //    auth: false
   }]
  });