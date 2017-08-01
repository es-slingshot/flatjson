package org.elasticsearch.ingest.bano;

import java.util.Collections;
import java.util.Map;

import org.elasticsearch.ingest.IngestDocument;
import org.elasticsearch.ingest.Processor;
import org.elasticsearch.plugins.IngestPlugin;
import org.elasticsearch.plugins.Plugin;

public class IngestBanoPlugin extends Plugin implements IngestPlugin {

    @Override
    public Map<String, Processor.Factory> getProcessors(Processor.Parameters parameters) {
        return Collections.singletonMap("flatjson-esplugin", new BanoProcessor.BanoFactory());
    }


}
