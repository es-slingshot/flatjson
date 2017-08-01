package org.elasticsearch.ingest.bano;

import static org.elasticsearch.ingest.ConfigurationUtils.readStringProperty;

import java.util.Map;

import org.elasticsearch.common.xcontent.XContentHelper;
import org.elasticsearch.common.xcontent.json.JsonXContent;
import org.elasticsearch.ingest.AbstractProcessor;
import org.elasticsearch.ingest.IngestDocument;
import org.elasticsearch.ingest.Processor;

public final class BanoProcessor extends AbstractProcessor {

    public final static String NAME = "flatjson-esplugin";
    private final String sourceField;
    private final String targetField;

    protected BanoProcessor(String tag, String sourceField, String targetField) {
        super(tag);
        this.sourceField = sourceField;
        this.targetField = targetField;
    }
    
    @Override
    public String getType() {
        return NAME;
    }

    @Override
    public void execute(IngestDocument ingestDocument) throws Exception {
        if (ingestDocument.hasField(sourceField)) {
            ingestDocument.setFieldValue(targetField, ingestDocument.getFieldValue(sourceField, String.class));
        }
    }

    public static final class BanoFactory implements Processor.Factory {
        @Override
        public Processor create(Map<String, Processor.Factory> processorFactories, String tag, Map<String, Object> config) throws
                Exception {
            String source = readStringProperty(NAME, tag, config, "source", "foo");
            String target = readStringProperty(NAME, tag, config, "target", "new_" + source);

            return new BanoProcessor(tag, source, target);
        }
    }

}
