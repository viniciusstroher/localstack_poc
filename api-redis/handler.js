'use strict';

module.exports.endpoint = (event, context, callback) => {
  // const response = {
  //   statusCode: 200,
  //   body: JSON.stringify({
  //     message: `Hello, the current time is ${new Date().toTimeString()}.`,
  //   }),
  // };

  const redis = require('redis');
  const client1 = redis.createClient();
  // var msg_count = 0;
  // var client2 = redis.createClient();

  // Most clients probably don't do much on 'subscribe'. This example uses it to coordinate things within one program.
  client1.on('subscribe', function (channel, count) {
      console.log('client1 subscribed to ' + channel + ', ' + count + ' total subscriptions');
      // if (count === 2) {
      //     client2.publish('a nice channel', 'I am sending a message.');
      //     client2.publish('another one', 'I am sending a second message.');
      //     client2.publish('a nice channel', 'I am sending my last message.');
      // }
  });

  client1.on('unsubscribe', function (channel, count) {
      console.log('client1 unsubscribed from ' + channel + ', ' + count + ' total subscriptions');
      if (count === 0) {
          // client2.end();
          client1.end();
      }
  });

  client1.on('message', function (channel, message) {
      console.log('client1 channel ' + channel + ': ' + message);
      msg_count += 1;
      // if (msg_count === 3) {
      //     client1.unsubscribe();
      // }
  });

  client1.on('ready', function () {
      // if you need auth, do it here
      console.log("REDIS ON")
      client1.incr('did a thing');
      client1.subscribe('a nice channel', 'another one');
  });

  
  client1.on('error', function (err) {
    console.log('error event - ' + client1.host + ':' + client1.port + ' - ' + err);
  });
  // client2.on('ready', function () {
  //     // if you need auth, do it here
  // });

  
  // https://github.com/NodeRedis/node-redis/tree/master/examples
};
