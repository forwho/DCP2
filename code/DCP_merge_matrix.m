function DCP_merge_matrix(opt)
  if ~exist(opt.merge.outputFile)
      mkdir(opt.merge.outputFile)
  end
  subFile=dir(opt.inputFile);
  if regexp(computer,'MACI') && strcmp(subFile(3).name, '.DS_Store')
        subFile(3)=[];
  end
  if strcmp(opt.sub,'All subjects')
      subIndex=3:length(subFile);
  else
      subIndex=eval([opt.sub ';'])+2;
  end
  trkname=['dti_' num2str(opt.tracktography.angle) '_' num2str(opt.tracktography.lowFA) '_' ...
        num2str(opt.tracktography.seed)];
  if opt.parcellation.aal==1
      atlasName='waal90';
      if opt.matrix.fn==1
          tmpName='FNum';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
      if opt.matrix.length==1
          tmpName='Length';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
      if opt.matrix.fa==1
          tmpName='dti_fa';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
      if opt.matrix.md==1
          tmpName='dti_md';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
  end
  if opt.parcellation.random==1
      atlasName='waal1024';
      if opt.matrix.fn==1
          tmpName='FNum';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
      if opt.matrix.length==1
          tmpName='Length';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
      if opt.matrix.fa==1
          tmpName='dti_fa';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
      if opt.matrix.md==1
          tmpName='dti_md';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
  end
  if ~isempty(opt.parcellation.otherAtlas)
      [atlasPath,atlasName,atlasfix]=fileparts(opt.parcellation.otherAtlas);
      atlasName=['w' atlasName];
      if opt.matrix.fn==1
          tmpName='FNum';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
      if opt.matrix.length==1
          tmpName='Length';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
      if opt.matrix.fa==1
          tmpName='dti_fa';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
      if opt.matrix.md==1
          tmpName='dti_md';
          merge_matrix(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,atlasName,tmpName);
      end
  end
  if opt.parcellation.nativeCheck==1
      if opt.matrix.fn==1
          tmpName='FNum';
          merge_matrix_native(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,tmpName);
      end
      if opt.matrix.length==1
          tmpName='Length';
          merge_matrix_native(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,tmpName);
      end
      if opt.matrix.fa==1
          tmpName='dti_fa';
          merge_matrix_native(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,tmpName);
      end
      if opt.matrix.md==1
          tmpName='dti_md';
          merge_matrix_native(opt.inputFile,opt.merge.outputFile,subFile,subIndex,trkname,tmpName);
      end
  end
end
function merge_matrix(inputFile,outputFile,subFile,subIndex,trkName,atlasName,tmpName)
    for i=subIndex
        load([inputFile filesep subFile(i).name filesep 'DCP_MATRIX' filesep...
            atlasName '_' trkName '_' tmpName '.mat']);
        eval([tmpName '.' subFile(i).name '=Matrix_' tmpName ';']);
    end
    save([outputFile filesep trkName '_' atlasName '_' tmpName '.mat'],...
        tmpName);
end
function merge_matrix_native(inputFile,outputFile,subFile,subIndex,trkName,tmpName)
    for i=subIndex
        load([inputFile filesep subFile(i).name filesep 'DCP_MATRIX' filesep...
            atlasName '_' trkName '_' subFile(i).name '.mat']);
        eval(['native.' subFile(i).name '=Matrix_' tmpName ';']);
    end
    save([outputFile filesep trkName '_' atlasName '_' 'native.mat'],...
        'native');
end