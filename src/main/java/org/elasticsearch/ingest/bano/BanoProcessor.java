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
    private final String jsonField;
    private final String prefix;

    protected BanoProcessor(String tag, String jsonField, String prefix) {
        super(tag);
        this.jsonField = jsonField;
        this.prefix = prefix;
    }
    
    @Override
    public String getType() {
        return NAME;
    }

    @Override
    public void execute(IngestDocument ingestDocument) throws Exception {

        Map<String, Object> mapValue
                = XContentHelper.convertToMap(JsonXContent.jsonXContent
                                    , ingestDocument.getFieldValue(jsonField
                        , String.class)
                                    ,false);

        // dispatch the json bloc to a list of new fields
        mapValue.entrySet().stream()
                .forEach(e -> ingestDocument.setFieldValue(prefix+"_"+e.getKey(), e.getValue()));

        // remove the previous field message
        ingestDocument.removeField("message");
    }

    public static final class BanoFactory implements Processor.Factory {
        @Override
        public Processor create(Map<String, Processor.Factory> processorFactories, String tag, Map<String, Object> config) throws
                Exception {
            String jsonField = readStringProperty(NAME, tag, config, "jsonField", "message");
            String prefix = readStringProperty(NAME, tag, config, "prefix", "msg");
            return new BanoProcessor(tag, jsonField, prefix);
        }
    }

}
