import mongoose from "mongoose";

const schema = new mongoose.Schema(
  { _hash: String },
  {
    strict: false,
    id: true,
  }
);
schema.set("toJSON", {
  virtuals: true,
});
const model = mongoose.model("SuggestedFeature", schema);

export default model;
