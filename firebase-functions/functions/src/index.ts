import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { Request, Response } from "firebase-functions";

admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest(
  (request: Request, response: Response) => {
    response.send("Hello from Firebase!");
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
