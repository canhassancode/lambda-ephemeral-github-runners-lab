import { CodeBuild } from "aws-sdk";

const codeBuild = new CodeBuild();

exports.handler = async () => {
  const params = {
    projectName: "github-runner",
  };

  try {
    const startBuildResponse = await codeBuild.startBuild(params).promise();
    console.log("Build started: ", startBuildResponse);
  } catch (error) {
    console.error("Error starting build: ", error);
  }
};
