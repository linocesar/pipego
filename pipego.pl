  #!/usr/bin/perl -w
  #Desenvolvedor: Lino Cesar
  #Interface grafica para o PGAP
  #https://github.com/linocesar/pipego.git

  use warnings;
  use strict;
  use Cwd;
  use Tk;
  use Encode qw(encode decode);
  use Tk::NoteBook;
  use File::Basename;


  my $genomas = "";
  my $output;
  my $input;
  my $message = "";
  my $funcoes = "";
  my $check1 = "cluster";
  my $check2 = "";
  my $check3 = "";
  my $check4 = "";
  my $check5 = "";
  my $metodo = "GF";
  my $auxmetodo = "GF";
  my $spin_id;
  my $spin_cov;

  my $chk1;
  my $chk2;
  my $chk3;
  my $chk4;
  my $chk5;
  chomp(my $numeroThreads = `nproc`);
  my $t = 1;
  my $aux = 1;
  ###top####
  my $Toplevel;
  my $lst;
  my $lst2;
  my $frame;
  my ($labelframe, $labelframe2, $labelframe3);
  my ($btt1, $btt2, $btt3, $btt4, $btt5);

  my $mw = MainWindow->new;
  
  # splash screen
  
  use Tk::Animation;
  use Tk::Splashscreen;
  $mw->withdraw;
  my $splash = $mw->Splashscreen(-milliseconds => 5000);
  my $animate;
  my $gif;
  eval{
    $gif = getcwd.'/icon.gif';
    $animate = $splash->Animation(-format => 'gif', -file => $gif);
  };
  if($@){
   $gif = Tk->findINC('anim.gif');
   $animate = $splash->Animation(-format => 'gif', -file => $gif);
  }

  $animate = $splash->Animation(-format => 'gif', -file => $gif);
  $splash->Label(-image => $animate)->pack;
  $animate->set_image(0);
  $animate->start_animation(50);
  $splash->Splash;		# show Splashscreen
  $mw->after(1000);
  $splash->Destroy;		# tear down Splashscreen
  $mw->deiconify;			# show calculator

  
 
  my $noteframe = $mw->Frame();
  my $main_menu = $mw->Menu();
  my $output_frame = $mw->Frame();
  my $msg_label = $mw->Label(-textvariable => \$message)->pack(-side=>'bottom', -fill=>'x');


  $mw->configure(-title=> "PIPE GO! v1.0",-background => 'white');
  $mw->minsize(1000,590);
  $mw->geometry("810x590+300+20");
  $mw->optionAdd('*font' => 'Roboto 9 bold');

  #splash screen

  #cria menu
  $mw->configure(-menu=>$main_menu);
  $main_menu->configure(-background=>'white', -relief=>'sunken', -borderwidth=>0.5, -activeborderwidth=>0.5);

  my $file_menu = $main_menu->cascade(-label=>decode('utf-8',"Opcões"),
                                      -underline => 0,
                                      -tearoff=>0);
  $file_menu->command(-label=>"Sair",
                      -underline=>0,
                      -command=>sub{exit});

  $main_menu->command(-label=>"Sobre",
                      -underline => 0,
                      -command=>sub{$mw->messageBox(-message=>decode('utf-8',"PIPE GO!\nVersion: 1.0.0\nDeveloper: Lino Cesar (github.com/linocesar)\nLab. de Genômica e Biologia de Sistemas\nLicenca: MIT"),
                                                    -type => "ok",-bg=>'white',
                                                    -width=>40)});


  #notebook
  my $book = $noteframe->NoteBook(-backpagecolor=>"white")->grid(-sticky=>'nsew')->pack(-fill=>'both', -side=>'top', -expand=>1);
  my $tab1 = $book;
  my $tab2 = $book;

  #frame
  my $frame_in = $mw->Frame(-borderwidth=>2, -container=>1);

  $frame_in = $tab1->add("pgap", -label=>'pgap');
  $frame_in->configure(-bg=>'AliceBlue');


  $frame_in->Label(-text=>decode('utf-8',"DataSource"), -bg=>"PowderBlue")->grid(-sticky=>'nsew', -pady=>5, -columnspan => 1);

  my $btt_filein = $frame_in->Button(-text => 'Input', -command=>\&open_dir_input, -width=>5)->grid(

  my $lbin = $frame_in->Label(-textvariable=>\$input,
                           -relief=>'groove',
                           -padx=>150,
                           -pady=>5,
                           -background=>'white'),
                           '-','-','-',-sticky=>'nsew', -padx => 2, -pady => 5);


  my $btt_fileout = $frame_in->Button(-text => 'Output', -command=>\&open_dir, -width=>5)-> grid(

  my $lbout = $frame_in->Label(-textvariable => \$output,
                            -relief=>'groove',
                            -padx=>150,
                            -pady=>5,
                            -background=>'white',
                            -foreground=>'black'),
                            '-','-','-', -sticky => 'nsew', -padx => 2, -pady => 5);

  my $btt_data = $frame_in->Button(-text=>'Dataset', -command=>\&open_cepas)->grid(-sticky=>'nsew', -pady=>5, -columnspan => 1);


  $frame_in->Label(-text=>decode('utf-8','ANÁLISE:'),
                   -bg=>"PowderBlue") -> grid(
  $chk1 = $frame_in->Checkbutton(-text => 'cluster',
                                 -variable => \$check1,
                                 -onvalue => "cluster",
                                 -offvalue => "",
                                -relief=>'raised',
                                -width=>14,
                                -selectcolor=>'#00FF00'),
  $chk2 = $frame_in->Checkbutton(-text => 'pangenome',
                                 -variable => \$check2,
                                 -onvalue => "pangenome",
                                 -offvalue => "",
                                 -relief=> 'raised',
                                 -width=>14,
                                 -selectcolor=>'#00FF00'),
  $chk3 = $frame_in->Checkbutton(-text => 'variation',
                                 -variable => \$check3,
                                 -onvalue => "variation",
                                 -offvalue => "",
                                 -relief=>'raised',
                                 -width=>14,
                                 -selectcolor=>'#00FF00'),
  $chk4 = $frame_in->Checkbutton(-text => 'evolution',
                                 -variable => \$check4,
                                 -onvalue => "evolution",
                                 -offvalue => "",
                                 -relief=>'raised',
                                 -width=>14,
                                 -selectcolor=>'#00FF00'),
  $chk5 = $frame_in->Checkbutton(-text => 'function',
                                 -variable => \$check5,
                                 -onvalue => "function",
                                 -offvalue => "",
                                 -relief=>'raised',
                                 -width=>14,
                                 -selectcolor=>'#00FF00'), -sticky=>'nsew', -padx=>1,-pady=>20, -ipady=>'3'); #fim Grid Checkbutton


  $frame_in->Label(-text=>decode('utf-8','MÉTODO:'),-bg=>"PowderBlue")
  -> grid(
  my $checkbutton1 = $frame_in->Radiobutton(-text=> 'GF',
                         -value=> 'GF',
                         -variable => \$auxmetodo,
                         -command=>\&get_metodo,
                         -relief=>'raised',
                         -selectcolor=>'#00FF00'),

  my $checkbutton2 = $frame_in->Radiobutton(-text=> 'MP',
                                             -value=> 'MP',
                                             -variable => \$auxmetodo,
                                             -command=>\&get_metodo,
                                             -relief=>'raised',
                                             -selectcolor=>'#00FF00'), -sticky=>'nsew', -padx=>1,-pady=>2, -ipady=>'3');

  ########### FRAME numero de threads

  $frame_in->Label(-text=>decode('utf-8','NÚMERO DE THREADS'),-bg=>"PowderBlue")
  ->grid(my $spin_t = $frame_in->Spinbox(-width => 2,
                                  -textvariable=>"1",
                                  -background=>'white',
                                  -from=> 1,
                                  -to=>$numeroThreads,
                                  -increment=>1),-sticky=>'nsew', -padx=>1,-pady=>20, -ipady=>'5');



  $frame_in->Label(-text=>decode('utf-8','IDENTIDADE'),-bg=>"PowderBlue")
  ->grid($spin_id = $frame_in->Spinbox(-width => 4,
                                          -textvariable=>"0.8",
                                          -background=>'white',
                                          -from=> 0.1,
                                          -to=>1.0,
                                          -increment=>0.1),-sticky=>'nsew', -padx=>1, -pady=>1, -ipady=>'5');

  ###############Frame COBERTURA

  $frame_in->Label(-text=>"COBERTURA", -bg=>'PowderBlue')->grid(
  $spin_cov = $frame_in->Spinbox( -width => 4,
                      -background=>'white',
                      -textvariable=>"0.9",
                      -from=> 0.1,
                      -to=>1,
                      -increment=>0.1),-sticky=>'nsew', -padx=>1, -pady=>15, -ipady=>'5');

  ###################FRAME EVALUE#################

  my $evalue;
  $frame_in->Label(-text=>'EVALUE', -bg=>'PowderBlue')->grid(
  $evalue = $frame_in->Entry(-relief=>'sunken', -background=>'white'),-sticky=>'nsew', -padx=>1, -pady=>8, -ipady=>'5');#->pack(-side=>'left');
  $evalue->insert('end', '0.00001');

  ## mensagem bind
  &bind_message($btt_filein, decode('utf-8',"Escolha o diretório de entrada de dados."));
  &bind_message($btt_fileout, decode('utf-8',"Escolha o diretório de saída."));
  &bind_message($chk1, "Cluster analysis of functional genes");
  &bind_message($chk2, "Pangenome profile analysis");
  &bind_message($chk3, "Genetic variation analysis of functional genes");
  &bind_message($chk4, "Species evolution analysis");
  &bind_message($chk5, "Function enrichment analysis of gene clusters");
  &bind_message($checkbutton1, decode('utf-8', "GF - Gene Family: fast, but not very accurate.\tMP - Multiparanoid: slow, but more accurate."));
  &bind_message($checkbutton2, decode('utf-8', "GF - Gene Family: fast, but not very accurate.\tMP - Multiparanoid: slow, but more accurate."));
  &bind_message($spin_id,"Minimum alignment indentity for two homologous proteins.");
  &bind_message($spin_cov,"Minimum alignment coverage for two homologous proteins.");
  &bind_message($evalue,"Maximal E-value in blastall.");

  my $btt_go;
  my $entry_mail;

  $frame_in->Label(-text => "E-MAIL", -bg=>'PowderBlue')->grid(
  $entry_mail = $frame_in->Entry(-text=>"",
                                 -fg=>"black",
                                 -bg=>'white'),'-',
  $btt_go = $frame_in->Button(-text=>"GO!", -bg=>'PowderBlue', -command=>\&executar), -sticky=>'nsew', -padx=>1,-pady=>5, -ipady=>'1');

  #############################NOTE REPORT#########################
  my $frame_report = $mw->Frame(-borderwidth=>2);
  $frame_report = $tab2->add("Report", -label=>"report");
  $frame_report->configure(-bg=>'white');

  $frame_report->Label(-text=>'')->pack(-side=>'top');



  $noteframe->pack(-fill => 'both', -side => 'top', -expand=>1); #####!!!!!!!!!!!!!!!Importante

  #### Funcoes ####

  sub get_cov {
    return $spin_cov->get;
  }

  sub getEmail {
    my $mail =  $entry_mail->get;
    my @aux = split(/\@/, $mail);

    return "$aux[0]\@$aux[1]";

  }


  sub get_evalue {
    return $evalue->get;
  }

  sub get_id {
    return $spin_id->get;
  }

  sub get_numeroprocess {
    $t = $spin_t->get;
    return $t;
  }

  ### Rotina principal
  sub executar {
    my $indentity = &get_id;
    my $coverage = &get_cov;
    my $f = &get_funcoes;
    my $met = &get_metodo;
    my $eval = &get_evalue;

    #exec("perl PGAP.pl -strains " . &get_strains . " -input $input -output $output ".&get_funcoes." -method ".&get_metodo." --thread ".&get_numeroprocess." --id ".&get_id." --cov ".&get_cov." --evalue ".&get_evalue." | tar -cjf report.tar.bz2 " .&getoutputdir." | echo 'PIPEGO REPORT' | mail -a report.tar.bz2 -s 'Job Done!' ".&getEmail);
    exec("perl PGAP.pl -strains ".&get_strains." -input $input -output $output $f -method $met --thread $t --id $indentity --cov $coverage --evalue $eval");

  }

  sub get_metodo {
    $metodo = $auxmetodo;
    return $metodo;
  }

  sub getoutputdir {

    my @aux = split("/", $output);

    return $aux[-1];

  }


  sub get_funcoes {
    $funcoes = "";

    if($check1 ne ""){
      $funcoes .=" --$check1";
    }
    if($check2 ne ""){
      $funcoes .=" --$check2";
    }

    if ($check3 ne "") {
      $funcoes .=" --$check3";
    }

    if ($check4 ne "") {
      $funcoes .=" --$check4";
    }

    if ($check5 ne "") {
      $funcoes .=" --$check5";
    }

    return $funcoes;

  }

  sub bind_message {
   my ($widget, $msg) = @_;
   $widget->bind('<Enter>', [ sub {$message = $_[1]; }, $msg ]);
   $widget->bind('<Leave>', sub {$message = ""; });
  }

  sub open_dir {

    $output = $mw->chooseDirectory(-initialdir => getcwd, -title => 'Escolha o diretorio de saida');

    $lbout->configure(-text=> $output);

  }

  sub open_dir_input { ## Falta tratamento para arquivo nao selecionado

    $input = $mw->chooseDirectory(-initialdir => getcwd, -title => 'Escolha o diretorio de entrada de dados');
    $lbin -> configure(-text => $input);

    if (Exists ($Toplevel)) {
        $Toplevel->destroy;
    }
      &open_cepas;

  }
  #####################################Toplevel##########################################################

  sub open_cepas {

    if (!Exists ($Toplevel)) {

      my @lista = &listar_arquivo;

      $frame = $mw->Frame()->pack(-side=>'left', -expand=>1, -fill=>'y');
      $Toplevel = $frame->Toplevel();
      $Toplevel->title("DATASET");
      $Toplevel->geometry("450x420+300+20");
      $Toplevel->raise();
      $Toplevel->protocol('WM_DELETE_WINDOW', sub{});
      
    my $labelframe = $Toplevel->Labelframe(-width => 200, -height => 200, -text => 'Dataset')
                           ->pack(-padx => 5, -pady => 5, -fill => 'both', -expand => 1, -side=>'left');

    $lst = $labelframe -> Scrolled('Listbox',-selectmode=>'extended', -bg => 'white', -selectbackground=> '#00BFFF', -selectforeground =>'white')
    ->pack(-fill=>'y', -expand=>1);

    $lst -> insert('end', @lista);

    my $labelframe2 = $Toplevel->Labelframe(-width => 50, -height => 50)
                            ->pack(-padx => 5, -pady => 5, -fill => 'x', -expand => 1, -side=>'left');

    my $btt1 = $labelframe2->Button(-text=>">", -command=>\&addOne)->pack(-fill=>'both', -expand=>1);
    my $btt2 = $labelframe2->Button(-text=>">>", -command=>\&addAll)->pack(-fill=>'both', -expand=>1);
    my $btt3 = $labelframe2->Button(-text=>"<",-command=>\&removeOne)->pack(-fill=>'both', -expand=>1);
    my $btt4 = $labelframe2->Button(-text=>"<<", -command=>\&removeAll)->pack(-fill=>'both', -expand=>1);
    my $btt5 = $labelframe2->Button(-text=>"ok", -command=>sub{$Toplevel->withdraw})->pack(-fill=>'both', -expand=>1);

    my $labelframe3 = $Toplevel->Labelframe(-width => 200, -height => 200, -text => 'Cepas excluidas')
                            ->pack(-padx => 5, -pady => 5, -fill => 'y', -expand => 1, -side=>'left');

    $lst2 = $labelframe3 -> Scrolled('Listbox',-bg => 'white', -selectmode=>'extended', -selectbackground=> '#00BFFF', -selectforeground =>'white')
    ->pack(-fill=>'y', -expand=>1);

    } else {
    $Toplevel->deiconify();
    $Toplevel->raise();
    }
  }

  sub addOne {
    my @lista_nova;
    my $tamanho = $lst->size();

    for (my $x = 0; $x < $tamanho; $x++) {

      my $ok = $lst -> selectionIncludes($x);

        if($ok == 1){
          $lst2 -> insert('end', $lst->get($x));
        }else{
          push @lista_nova, $lst->get($x);
        }

    }

    $lst -> delete(0, 'end');
    $lst -> insert('end', sort @lista_nova);
    $lst->selectionClear(0, 'end');
  }

  sub addAll {
    my @elementos = $lst->get(0, 'end');
    $lst2 -> insert("end", @elementos);
    $lst -> delete(0, 'end');
  }

  sub removeOne {
    my @lista_nova;
    my $tamanho = $lst2->size();

    for (my $x = 0; $x < $tamanho; $x++) {

      my $ok = $lst2 -> selectionIncludes($x);

        if($ok == 1){
          $lst -> insert('end', $lst2->get($x));
        }else{
          push @lista_nova, $lst2->get($x);
        }

    }

    $lst2 -> delete(0, 'end');
    $lst2 -> insert('end', @lista_nova);
    $lst2->selectionClear(0, 'end');
  }

  sub removeAll {
    my @elementos = $lst2->get(0, 'end');
    $lst -> insert('end', @elementos);
    $lst2 -> delete(0, 'end');
  }

  sub get_strains {

    $genomas = "";

    my @aux = $lst->get(0, 'end');

    foreach my $x (@aux) {
        $genomas .= $x."+";
    }

    $genomas =~ s/[+]*$//g;

    return $genomas;

  }

  sub listar_arquivo {

    my %map;
    my @list;

    opendir(DIR, $input) or die $!;

        while (my $file = readdir(DIR)) {
          chomp($file);

          if($file =~ /.pep*$|.nuc*$|.function*$/){
              $file =~ s/.pep*$|.nuc*$|.function*$//;
              $map{$file}++;

        }
    }closedir(DIR);

    foreach my $x (sort keys %map) {
      if($map{$x} == 3){
        push(@list, $x);
      }
    }

  return @list;

  }

  MainLoop();