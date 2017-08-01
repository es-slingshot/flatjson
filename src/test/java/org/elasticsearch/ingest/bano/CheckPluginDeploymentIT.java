package org.elasticsearch.ingest.bano;

import java.io.IOException;
import java.util.List;

import com.spotify.docker.client.DefaultDockerClient;
import com.spotify.docker.client.DockerClient;
import com.spotify.docker.client.LogStream;
import com.spotify.docker.client.exceptions.DockerCertificateException;
import com.spotify.docker.client.exceptions.DockerException;
import com.spotify.docker.client.messages.Container;
import org.junit.Assert;
import org.junit.Assume;
import org.junit.Test;

public class CheckPluginDeploymentIT {

    @Test
    public void testRecordsLogs() throws InterruptedException, IOException, DockerException, DockerCertificateException {
        final DockerClient docker = DefaultDockerClient.fromEnv().build();
        List<Container> containers = docker.listContainers(DockerClient.ListContainersParam.withLabel("org.slingshot.plugin", "flatjson"));
        if (containers != null && containers.size()==1) {
            System.out.println(containers.get(0).toString());
            final LogStream output = docker.logs(containers.get(0).id(), DockerClient.LogsParam.stdout(), DockerClient.LogsParam.stderr());
            final String execOutput = output.readFully();
            System.out.println(execOutput);
            Assert.assertTrue("Logs should contains 'x-pack'", execOutput.contains("x-pack"));
        }
        Assume.assumeTrue(false);
    }


}