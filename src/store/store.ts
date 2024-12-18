import { configureStore } from "@reduxjs/toolkit";
import walkReducer from "./features/walkSlice";

const store = configureStore({
	reducer: {
		currentWalk: walkReducer,
	},
});

export type RootState = ReturnType<typeof store.getState>;

export default store;
