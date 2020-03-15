import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { Request, Response } from "firebase-functions";

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  databaseURL: 'https://webrtc-test-deb99.firebaseio.com',
});
const db = admin.firestore();
const fcm = admin.messaging();

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest(
  (request: Request, response: Response) => {
    response.send("Hello from Firebase!");
  }
);

function sleep(millis: number) {
  return new Promise(resolve => setTimeout(resolve, millis));
}

export const sendPlateNotification = functions.https.onRequest(
  async (request: Request, response: Response) => {
    console.log(request.body);
    const body: { plate: string; seconds: number; token:string } = JSON.parse(request.body);
    if ("seconds" in body) {
      await sleep(body.seconds * 1000);
    }

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: `New transaction for ${body.plate}.`,
        body: `We have detected a car with plates ${body.plate}, open to accept the transaction.`,
        click_action: "FLUTTER_NOTIFICATION_CLICK" // required only for onResume or onLaunch callbacks
      }
    };
    // return fcm.sendToTopic(
    //   `/topics/${body.plate.trim().replace(" ", "_")}`,
    //   payload
    // );
    return fcm.sendToDevice(body.token, payload);
  }
);

export const sendToTopic = functions.firestore
  .document("puppies/{puppyId}")
  .onCreate(async (snapshot: admin.firestore.DocumentSnapshot) => {
    const puppy = snapshot.data();

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: "New Puppy!",
        body: `${puppy.name} is ready for adoption`,
        icon: "your-icon-url",
        click_action: "FLUTTER_NOTIFICATION_CLICK" // required only for onResume or onLaunch callbacks
      }
    };

    return fcm.sendToTopic("puppies", payload);
  });

export const sendToDevice = functions.firestore
  .document("orders/{orderId}")
  .onCreate(async (snapshot: admin.firestore.DocumentSnapshot) => {
    const order = snapshot.data();

    const querySnapshot = await db
      .collection("users")
      .doc(order.seller)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map(
      (snap: admin.firestore.QueryDocumentSnapshot) => snap.id
    );

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: "New Order!",
        body: `you sold a ${order.product} for ${order.total}`,
        icon: "your-icon-url",
        click_action: "FLUTTER_NOTIFICATION_CLICK"
      }
    };

    return fcm.sendToDevice(tokens, payload);
  });
